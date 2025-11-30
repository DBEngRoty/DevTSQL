DECLARE @vEmailRecip  VARCHAR(2000);   SET @vEmailRecip = SPACE(0);
SELECT @vEmailRecip = @vEmailRecip + Email +';' FROM Test.dbo.[Alerts_Emails_Distribution_List] WHERE  [Active]='Y' AND [Alert_LCS]  = 'Y' 
PRINT @vEmailRecip;


USE [Test]
GO

CREATE TABLE [dbo].[Alerts_Emails_Distribution_List](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[Active] [char](1) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Alert_LCS] [varchar](50) NOT NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO