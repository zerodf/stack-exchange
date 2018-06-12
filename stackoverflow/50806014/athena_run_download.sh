#!/usr/bin/env bash

# Used the above Shebang line for portability

# What follows is one liner to call a SQL query in Athena, 
# wait for it to finish, and download the results

eid=`aws athena start-query-execution --query-string "select count(*) from test_null_unquoted" --query-execution-context Database=SOMEDATABASE--result-configuration OutputLocation=s3://SOMEBUCKET/ --output text --output text` && until aws athena get-query-execution --query-execution-id=$eid --output text | grep "SUCCEEDE
D"; do sleep 30 | echo "waiting..."; done && aws s3 cp s3://SOMEBUCKET/$eid.csv . && unset eid
