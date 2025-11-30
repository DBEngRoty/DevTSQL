-- Sample T-SQL Script to demonstrate Certificate Encryption

-- Use the AdventureWorks database
USE AdventureWorks;

-- Create a Database Master Key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'p@ssw0rd';

-- Create a Temp Table
CREATE TABLE Person.#Temp
(ContactID   INT PRIMARY KEY,
 FirstName   NVARCHAR(200),
 MiddleName  NVARCHAR(200),
 LastName    NVARCHAR(200),
 eFirstName  VARBINARY(200),
 eMiddleName VARBINARY(200),
 eLastName   VARBINARY(200));

-- Create a Test Certificate, encrypted by the DMK
CREATE CERTIFICATE TestCertificate
   WITH SUBJECT = 'Adventureworks Test Certificate',
   EXPIRY_DATE = '10/31/2009';

-- EncryptByCert demonstration encrypts 100 names from the Person.Contact table
INSERT
INTO Person.#Temp (ContactID, eFirstName, eMiddleName, eLastName)
SELECT ContactID, EncryptByCert(Cert_ID('TestCertificate'), FirstName),
	EncryptByCert(Cert_ID('TestCertificate'), MiddleName), 
	EncryptByCert(Cert_ID('TestCertificate'), LastName)
FROM Person.Contact
WHERE ContactID <= 100;

-- DecryptByCert demonstration decrypts the previously encrypted data
UPDATE Person.#Temp
SET FirstName = DecryptByCert(Cert_ID('TestCertificate'), eFirstName),
	MiddleName = DecryptByCert(Cert_ID('TestCertificate'), eMiddleName),
	LastName = DecryptByCert(Cert_ID('TestCertificate'), eLastName);

-- View the results
SELECT *
FROM Person.#Temp;

-- Clean up work:  drop temp table, test certificate and master key
DROP TABLE Person.#Temp;
DROP CERTIFICATE TestCertificate;
DROP MASTER KEY;