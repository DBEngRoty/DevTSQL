-- sqlcmd Utility
-- SQL Server 2016  
-- The sqlcmd utility lets you enter Transact-SQL statements, system procedures, and script files at the command prompt, 
-- in Query Editor in SQLCMD mode, in a Windows script file or in an operating system (Cmd.exe) job step of a SQL Server Agent job. 
-- This utility uses ODBC to execute Transact-SQL batches.


sqlcmd-a packet_size-A (dedicated administrator connection)
   -b (terminate batch job if there is an error)
   -c batch_terminator-C (trust the server certificate)
   -d db_name-e (echo input)
   -E (use trusted connection)
   -f codepage | i:codepage[,o:codepage] | o:codepage[,i:codepage]
   -h rows_per_header-H workstation_name-i input_file-I (enable quoted identifiers)
   -k[1 | 2] (remove or replace control characters)
   -K application_intent-l login_timeout-L[c] (list servers, optional clean output)
   -m error_level-M multisubnet_failover-N (encrypt connection)
   -o output_file-p[1] (print statistics, optional colon format)
   -P password-q "cmdline query"-Q "cmdline query" (and exit)
   -r[0 | 1] (msgs to stderr)
   -R (use client regional settings)
   -s col_separator-S [protocol:]server[\instance_name][,port]
   -t query_timeout-u (unicode output file)
   -U login_id-v var = "value"-V error_severity_level-w column_width-W (remove trailing spaces)
   -x (disable variable substitution)
   -X[1] (disable commands, startup script, environment variables and optional exit)
   -y variable_length_type_display_width-Y fixed_length_type_display_width-z new_password -Z new_password (and exit)

