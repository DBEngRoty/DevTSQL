-- Get element from untyped XML
-- SCI is the root of XML
-- Lead is a node
-- @LeadID is the label

SELECT 
Convert(xml,clob_data),
Convert(xml,clob_data).value('(/SCI/Lead/@BatchID)[1]','bigint'),
Convert(xml,clob_data).value('(/SCI/Lead/@LeadID)[1]','bigint') 
FROM dbo.Mig_LPLS_Lead




-- Matching_vehicles
INSERT INTO LPLS.dbo.matching_pool(
LPLS_lead_id, provider_id, dealer_id, lead_class_id, lead_source_id, lead_phase_id, dealer_group_id, 
business_indicator, first_name, last_name, company_name, address_line_one, city, home_phone, mobile_phone,
office_phone, office_phone_ext, surrogate_id, email_address_home, email_address_work, created_date_time)

SELECT 
LPLS_lead_id,
Convert(xml,clob_data).value('(/SCI/Lead/Provider/Id)[1]','int') as provider_id,
Convert(xml,clob_data).value('(/SCI/Lead/Vendor/Id)[1]','int') as dealer_id,
--Convert(xml,clob_data).value('(/SCI/Lead/@LeadClassName)[1]','VARCHAR(50)') as classname,
(CASE WHEN Convert(xml,clob_data).value('(/SCI/Lead/@LeadClassName)[1]','VARCHAR(50)')='Sales' then 1 WHEN Convert(xml,clob_data).value('(/SCI/Lead/@LeadClassName)[1]','VARCHAR(50)')='Services' then 2  WHEN Convert(xml,clob_data).value('(/SCI/Lead/@LeadClassName)[1]','VARCHAR(50)')='Parts Request' then 3 ELSE 2 END) as lead_class_id,
(CASE WHEN SOURCE='LCS' THEN Convert(xml,clob_data).value('(/SCI/Lead/@SourceID)[1]','int') ELSE 701 END) as lead_source_id,
(CASE WHEN SOURCE='LCS' THEN 2 WHEN SOURCE='LF' THEN 1 ELSE 2 END) AS Lead_Phase_ID,
--Convert(xml,clob_data).value('(/SCI/Lead/LeadSponsor/Name)[1]','VARCHAR(50)') as Lead_SponsorName,
(CASE WHEN Convert(xml,clob_data).value('(/SCI/Lead/LeadSponsor/Name)[1]','VARCHAR(50)')='General Motors' then 1 WHEN Convert(xml,clob_data).value('(/SCI/Lead/LeadSponsor/Name)[1]','VARCHAR(50)')='Penske Automotive' then 2  WHEN Convert(xml,clob_data).value('(/SCI/Lead/LeadSponsor/Name)[1]','VARCHAR(50)')='Saab' then 3 ELSE 1 END) as dealer_group_id,
--Convert(xml,clob_data).value('(/SCI/Lead/MiscData/BusinessIndicator)[1]','VARCHAR(50)') as Bus_Ind,
(CASE WHEN Convert(xml,clob_data).value('(/SCI/Lead/MiscData/BusinessIndicator)[1]','VARCHAR(50)')='Commercial' then 1 ELSE 0 END) as business_indicator,
Convert(xml,clob_data).value('(/SCI/Lead/Customer/Contact/Name[@Part="first" and @Type="individual"])[1]','VARCHAR(50)') AS First_name,
Convert(xml,clob_data).value('(/SCI/Lead/Customer/Contact/Name[@Part="last" and @Type="individual"])[1]','VARCHAR(50)') AS Last_name,
Convert(xml,clob_data).value('(/SCI/Lead/Customer/Contact/Name[@Part="full" and @Type="company"])[1]','VARCHAR(50)') AS Company_Name,
Convert(xml,clob_data).value('(/SCI/Lead/Customer/Contact/Address/Street[@Line="1"])[1]','VARCHAR(50)') AS Address_line_one,
Convert(xml,clob_data).value('(/SCI/Lead/Customer/Contact/Address/City)[1]','VARCHAR(50)') AS city,
Convert(xml,clob_data).value('(/SCI/Lead/Customer/Contact/Phone[@ChannelCode="Home Phone"])[1]','VARCHAR(10)') AS Home_Phone,
Convert(xml,clob_data).value('(/SCI/Lead/Customer/Contact/Phone[@ChannelCode="Cell Phone"])[1]','VARCHAR(10)') AS Mobile_Phone,
Convert(xml,clob_data).value('(/SCI/Lead/Customer/Contact/Phone[@ChannelCode="Business Phone"])[1]','VARCHAR(10)') AS Office_Phone,
Convert(xml,clob_data).value('(/SCI/Lead/Customer/Contact/Phone[@ChannelCode="Business Phone"]/Extension)[1]','VARCHAR(5)') AS Office_Phone_Ext,
Convert(xml,clob_data).value('(/SCI/Lead/Everest/GMLeadAppendReply/SurrogateID)[1]','bigint') AS surogate_id,
Convert(xml,clob_data).value('(/SCI/Lead/Customer/Contact/EMail[Type="Personal Email"])[1]','VARCHAR(50)') AS email_address_home,
Convert(xml,clob_data).value('(/SCI/Lead/Customer/Contact/EMail[Type="Office Email"])[1]','VARCHAR(50)') AS email_address_work,
GETUTCDATE() as created_date_time
FROM dbo.Mig_LPLS_Lead
WHERE LPLS_lead_id NOT IN (SELECT LPLS_lead_id FROM LPLS.dbo.Matching_pool)