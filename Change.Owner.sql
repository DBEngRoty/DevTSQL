sp_changeobjectowner [ @objname = ] 'object' , [ @newowner = ] 'owner'
EXEC sp_changeobjectowner 'authors', 'Corporate\GeorgeW'
EXEC sp_changeobjectowner 'PROTARIU.authors', 'dbo'

