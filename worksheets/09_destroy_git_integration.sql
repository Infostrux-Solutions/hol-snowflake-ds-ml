USE ROLE ACCOUNTADMIN;

-- Drop the git repository
DROP GIT REPOSITORY IF EXISTS HOL_LAB_DATASCIENCE.LAB.hol_iff;

-- Drop the API integration
DROP API INTEGRATION IF EXISTS HOL_LAB_DATASCIENCE_git_api_integration;

-- Drop the external access integration
DROP EXTERNAL ACCESS INTEGRATION IF EXISTS pypi_access_integration;

-- Drop the network rule
DROP NETWORK RULE IF EXISTS pypi_network_rule;

-- Drop the LAB schema
DROP SCHEMA IF EXISTS HOL_LAB_DATASCIENCE.LAB; 