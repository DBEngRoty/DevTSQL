DECLARE @source_code_id INT; 
DECLARE @Program_ID int;
DECLARE @Sub_Program_Name VARCHAR(80);


declare Curs1 cursor for select [Program_id], [Sub_Program_Name], source_code_id  from  SCC_Update.dbo.DataSet4
open Curs1
FETCH next from Curs1 INTO @source_code_id, @Program_ID, @Sub_Program_Name
WHILE (@@fetch_status = 0)
BEGIN
	UPDATE SC SET SC.program_id = 
	(SELECT TOP 1 program_id FROM SCC.DBO.Program WHERE parent_program_id=@Program_ID AND [program_name]=@Sub_Program_Name AND program_number LIKE 'Subprogram%')
	FROM SCC.DBO.source_code AS SC WHERE SC.source_code_id  = @source_code_id;
    FETCH NEXT FROM Curs1 INTO @source_code_id, @Program_ID, @Sub_Program_Name;
END

CLOSE Curs1;
DEALLOCATE Curs1;








declare curPO cursor
for select Product_ID, CurrentPOs from #t1
for update of CurrentPOs
open curPO

fetch next from curPO

while @@fetch_status = 0
begin
    select      OrderQuantity = <calculation>,
                ReceiveQuantity = <calculation>
    into    	#POs
    from        PurchaseOrderLine POL 
    inner join  SupplierAddress SA ON POL.Supplier_ID = SA.Supplier_ID
    inner join  PurchaseOrderHeader POH ON POH.PurchaseOrder_ID = POL.PurchaseOrder_ID
    where       Product_ID = curPO.Product_ID
    and         SA.AddressType = '1801'

    update curPO set CurrentPOs = (select sum(OrderQuantity) - sum(ReceiveQuantity) from #POs)

    drop table #POs

    fetch next from curPO
end

close curPO
deallocate curPO