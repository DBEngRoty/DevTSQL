SELECT PHONE, COUNT(PHONE) FROM dbo.CRTC_DNC 
GROUP BY PHONE 
HAVING COUNT(DISTINCT PHONE)>1

select email_address, count (*) from ##to_thindata_csv
group by email_address
having count (*)>1

