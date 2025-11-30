SELECT     A.M_FName, B.M_FName AS Expr1, A.M_LName, B.M_LName AS Expr2, A.M_Postal, B.M_Postal AS Expr3, A.M_General, B.M_General AS Expr4, 
                      A.M_SuiteNum, B.M_SuiteNum AS Expr5, A.M_CivicNum, B.M_CivicNum AS Expr6, A.M_Street, B.M_Street AS Expr7, A.M_POBOX, 
                      B.M_POBox AS Expr8, A.M_Rural, B.M_Rural AS Expr9, A.M_GD, B.M_GD AS Expr10
FROM         dbo.STD_STAGE A,
                      dbo.SS_STAGE B
WHERE     (A.M_Postal LIKE 'L%') AND A.M_Postal = B.M_Postal