SELECT a.prosp_id, a.postal, b.valpost ;

            FROM \\Cdi5\CIBC\MasterDB\CURRENT\city_prov_pc a, \\Cdi5\CIBC\MasterDB\CURRENT\uc_profiles b ;

            WHERE (a.prosp_id = b.prosp_id) and ;

           (SUBSTR(a.postal,1,1)$("ABCEGHJKLMNPRSTVXY") = .F. or ;

           SUBSTR(a.postal,2,1) not BETWEEN '0' and '9' or ;

           SUBSTR(a.postal,3,1) not BETWEEN 'A' and 'Z' or ;

           SUBSTR(a.postal,3,1)$("DFIOQU") = .T. or ;

           SUBSTR(a.postal,4,1) not BETWEEN '0' and '9' or ;

           SUBSTR(a.postal,5,1) not BETWEEN 'A' and 'Z' or ;

           SUBSTR(a.postal,5,1) $("DFIOQU") = .T. or ;

           SUBSTR(a.postal,6,1) not BETWEEN '0' and '9' ) ;

           and b.valpost = .t. ;

     INTO TABLE C:\CIBC\QA_Results\ACME_ERROR_VALPOST_1.dbf  

 

 

 

