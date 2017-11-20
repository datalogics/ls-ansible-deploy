#!/bin/bash
export PGPASSWORD={{ psql_password }}

psql -h {{ hostvars['localhost']['rds']['instance']['endpoint'] }} -p 5432 -U {{ psql_username }} {{ psql_db_name }}
