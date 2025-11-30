USE [LeadDriver];

ALTER TABLE [LeadDriver].dbo.[gateway_destination]  ALTER COLUMN [destination_id] INT NOT NULL;

update LeadDriver..gateway_destination set destination_id = 4000 where destination_id = 1

--ALTER TABLE [ResponseDriver_I].[dbo].[email_queue_tmp] ALTER COLUMN [destination_id] INT NULL;

-- STEPS HERE!!!!
ALTER TABLE yourTable DROP CONSTRAINT PK_yourTable_id;
alter table yourTable drop column id;
EXEC sp_rename 'yourTable.tempId', 'id', 'COLUMN';
ALTER TABLE yourTable ADD CONSTRAINT PK_yourTable_id PRIMARY KEY (id) 
commit;



-- You have 2 options,
-- 1. Create a new table with identity & drop the existing table
-- 2. Create a new column with identity & drop the existing column


SET IDENTITY_INSERT [MarketingProgramAttributes] ON

Insert into [dbo].[MarketingProgramAttributes]
([ID], [MarketingProgramID], [AttributeTypeID], [Value], [MinAmount], [MaxAmount], [StartDate], [EndDate])
SELECT
[ID], [MarketingProgramID], [AttributeTypeID], [Value], [MinAmount], [MaxAmount], [StartDate], [EndDate] FROM MarketingProgramAttributes_OLD

SET IDENTITY_INSERT [MarketingProgramAttributes] Off

SELECT * FROM [MarketingProgramAttributes]


ALTER TABLE [dbo].[MarketingProgramAttributes]  WITH CHECK ADD  CONSTRAINT [FK_MarketingProgramAttributes_MarketingProgramAttributeTypes] FOREIGN KEY([AttributeTypeID])
REFERENCES [dbo].[MarketingProgramAttributeTypes] ([ID])
GO

ALTER TABLE [dbo].[MarketingProgramAttributes] CHECK CONSTRAINT [FK_MarketingProgramAttributes_MarketingProgramAttributeTypes]
GO

ALTER TABLE [dbo].[MarketingProgramAttributes]  WITH CHECK ADD  CONSTRAINT [FK_MarketingProgramAttributes_MarketingPrograms] FOREIGN KEY([MarketingProgramID])
REFERENCES [dbo].[MarketingPrograms] ([ID])
GO

ALTER TABLE [dbo].[MarketingProgramAttributes] CHECK CONSTRAINT [FK_MarketingProgramAttributes_MarketingPrograms]
GO
