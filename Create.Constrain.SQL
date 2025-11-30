ALTER TABLE dbo.ValidPhones ADD CONSTRAINT
ProspectClassificationUniverse_ValidPhones_FK1 FOREIGN KEY (IntraInterfaceID,InterfaceID)
REFERENCES dbo.ProspectClassificationUniverse (IntraInterfaceID,InterfaceID) 
ON UPDATE  NO ACTION 
ON DELETE  NO ACTION 
				
				
				
				

ALTER TABLE Sources
ADD CONSTRAINT ProspectClassificationUniverse_Sources_FK1 FOREIGN KEY (PID)
REFERENCES ProspectClassificationUniverse(PID) ON UPDATE NO ACTION ON DELETE NO ACTION

 

ALTER TABLE ModelScores
ADD CONSTRAINT ProspectClassificationUniverse_ModelScores_FK1 FOREIGN KEY (PID)
REFERENCES ProspectClassificationUniverse(PID) ON UPDATE NO ACTION ON DELETE NO ACTION

 

