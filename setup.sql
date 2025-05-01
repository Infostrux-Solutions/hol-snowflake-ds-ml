/*
-- This script sets up a Snowflake environment for the IFF HOL event in Paris, March 2025.

-- 1. Switch to ORGADMIN role to create a new organization account.
-- 2. Create a new organization account named HOL_LAB_DATASCIENCE with specified admin details and settings.
-- 3. Switch to ACCOUNTADMIN role to perform account-level operations.
-- 4. Create a new database named HOL_LAB_DATASCIENCE.
-- 5. Create two warehouses (WH_1_HOL_LAB_DATASCIENCE and WH_2_HOL_LAB_DATASCIENCE) with specified configurations.
-- 6. Create a new role ROLE_HOL_LAB_DATASCIENCE and grant ownership of the database and usage/operate permissions on the warehouses to this role.
-- 7. Grant permissions to create notebooks, Streamlit apps, and models on future schemas in the database to the role.
-- 8. Grant the new role to the SYSADMIN role and to the user FABIAN.
-- 9. Switch to the new role and create a schema named LAB within the database.
-- 10. Switch back to ACCOUNTADMIN role to create API and external access integrations.
-- 11. Create an API integration for GitHub with allowed prefixes and enable it.
-- 12. Create a Git repository in the LAB schema linked to the specified GitHub repository.
-- 13. Create a network rule for accessing PyPI and an external access integration using this rule.
-- 14. Grant usage on the external access integration and read access on the Git repository to the new role.
-- 15. Switch back to the new role to complete the setup.
-- 16. Setup the participant's schemas and notebooks.
*/
-- USE ROLE ORGADMIN;

-- CREATE ORGANIZATION ACCOUNT HOL_LAB_DATASCIENCE
--     ADMIN_NAME = 'FABIAN'
--     ADMIN_PASSWORD = '*****'
--     FIRST_NAME = 'FABIAN'
--     LAST_NAME = 'HERNANDEZ'
--     EMAIL = 'fabian@infostrux.com'
--     MUST_CHANGE_PASSWORD = TRUE
--     EDITION = 'BUSINESS_CRITICAL'
--     REGION = 'AWS_US_WEST_2'
--     COMMENT = 'Snowflake account for IFF HOL in Paris-March, 2025';

USE ROLE ACCOUNTADMIN;

-- ------------------------------------------------------------------------------------------------------------------------ --
-- 1. SETUP DATABASES --
-- ------------------------------------------------------------------------------------------------------------------------ --

CREATE DATABASE HOL_LAB_DATASCIENCE;

-- ------------------------------------------------------------------------------------------------------------------------ --
-- 2. SETUP WAREHOUSES --
-- ------------------------------------------------------------------------------------------------------------------------ --

CREATE WAREHOUSE WH_1_HOL_LAB_DATASCIENCE
  WITH
  WAREHOUSE_SIZE = 'XSMALL'
  WAREHOUSE_TYPE = 'STANDARD'
  MAX_CLUSTER_COUNT = 10
  MIN_CLUSTER_COUNT = 1
  SCALING_POLICY = 'STANDARD'
  AUTO_SUSPEND = 300
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE;

CREATE WAREHOUSE WH_2_HOL_LAB_DATASCIENCE
  WITH
  WAREHOUSE_SIZE = 'XSMALL'
  WAREHOUSE_TYPE = 'STANDARD'
  MAX_CLUSTER_COUNT = 10
  MIN_CLUSTER_COUNT = 1
  SCALING_POLICY = 'STANDARD'
  AUTO_SUSPEND = 300
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE;

CREATE WAREHOUSE WH_3_HOL_LAB_DATASCIENCE
  WITH
  WAREHOUSE_SIZE = 'XSMALL'
  WAREHOUSE_TYPE = 'STANDARD'
  MAX_CLUSTER_COUNT = 10
  MIN_CLUSTER_COUNT = 1
  SCALING_POLICY = 'STANDARD'
  AUTO_SUSPEND = 300
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE;

CREATE WAREHOUSE WH_4_HOL_LAB_DATASCIENCE
  WITH
  WAREHOUSE_SIZE = 'XSMALL'
  WAREHOUSE_TYPE = 'STANDARD'
  MAX_CLUSTER_COUNT = 10
  MIN_CLUSTER_COUNT = 1
  SCALING_POLICY = 'STANDARD'
  AUTO_SUSPEND = 300
  AUTO_RESUME = TRUE
  INITIALLY_SUSPENDED = TRUE;

-- ------------------------------------------------------------------------------------------------------------------------ --
-- 3. SETUP ROLES --
-- ------------------------------------------------------------------------------------------------------------------------ --
  
CREATE OR REPLACE ROLE ROLE_HOL_LAB_DATASCIENCE;
GRANT OWNERSHIP ON DATABASE HOL_LAB_DATASCIENCE TO ROLE ROLE_HOL_LAB_DATASCIENCE;

GRANT USAGE ON WAREHOUSE WH_1_HOL_LAB_DATASCIENCE TO ROLE ROLE_HOL_LAB_DATASCIENCE;
GRANT OPERATE ON WAREHOUSE WH_1_HOL_LAB_DATASCIENCE TO ROLE ROLE_HOL_LAB_DATASCIENCE;

GRANT USAGE ON WAREHOUSE WH_2_HOL_LAB_DATASCIENCE TO ROLE ROLE_HOL_LAB_DATASCIENCE;
GRANT OPERATE ON WAREHOUSE WH_2_HOL_LAB_DATASCIENCE TO ROLE ROLE_HOL_LAB_DATASCIENCE;

GRANT USAGE ON WAREHOUSE WH_3_HOL_LAB_DATASCIENCE TO ROLE ROLE_HOL_LAB_DATASCIENCE;
GRANT OPERATE ON WAREHOUSE WH_3_HOL_LAB_DATASCIENCE TO ROLE ROLE_HOL_LAB_DATASCIENCE;

GRANT USAGE ON WAREHOUSE WH_4_HOL_LAB_DATASCIENCE TO ROLE ROLE_HOL_LAB_DATASCIENCE;
GRANT OPERATE ON WAREHOUSE WH_4_HOL_LAB_DATASCIENCE TO ROLE ROLE_HOL_LAB_DATASCIENCE;

GRANT CREATE NOTEBOOK ON FUTURE SCHEMAS IN DATABASE HOL_LAB_DATASCIENCE TO ROLE ROLE_HOL_LAB_DATASCIENCE;
GRANT CREATE STREAMLIT ON FUTURE SCHEMAS IN DATABASE HOL_LAB_DATASCIENCE TO ROLE ROLE_HOL_LAB_DATASCIENCE;
GRANT CREATE MODEL ON FUTURE SCHEMAS IN DATABASE HOL_LAB_DATASCIENCE TO ROLE ROLE_HOL_LAB_DATASCIENCE;
GRANT ROLE ROLE_HOL_LAB_DATASCIENCE TO ROLE SYSADMIN;

-- User assignment.
GRANT ROLE ROLE_HOL_LAB_DATASCIENCE TO USER NASKO;

-- ------------------------------------------------------------------------------------------------------------------------ --
-- 3. SETUP GIT INTEGRATION --
-- ------------------------------------------------------------------------------------------------------------------------ --

USE ROLE ROLE_HOL_LAB_DATASCIENCE;
CREATE SCHEMA HOL_LAB_DATASCIENCE.LAB; 

USE ROLE ACCOUNTADMIN;

CREATE OR REPLACE API INTEGRATION HOL_LAB_DATASCIENCE_git_api_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/Infostrux-Solutions/')
  ENABLED = TRUE;

CREATE OR REPLACE GIT REPOSITORY HOL_LAB_DATASCIENCE.LAB.hol_iff
  API_INTEGRATION = HOL_LAB_DATASCIENCE_git_api_integration
  ORIGIN = 'https://github.com/Infostrux-Solutions/hol-snowflake-ds-ml';

CREATE OR REPLACE NETWORK RULE pypi_network_rule
  MODE = EGRESS
  TYPE = HOST_PORT
  VALUE_LIST = ('pypi.org', 'pypi.python.org', 'pythonhosted.org',  'files.pythonhosted.org');

CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION pypi_access_integration
  ALLOWED_NETWORK_RULES = (pypi_network_rule)
  ENABLED = true;


GRANT USAGE ON INTEGRATION pypi_access_integration TO ROLE ROLE_HOL_LAB_DATASCIENCE;
GRANT READ ON GIT REPOSITORY HOL_LAB_DATASCIENCE.LAB.hol_iff TO ROLE ROLE_HOL_LAB_DATASCIENCE;

-- ------------------------------------------------------------------------------------------------------------------------ --
-- 4. SETUP NAMED USERS, SCHEMAS, STAGES, NOTEBOOKS --
-- ------------------------------------------------------------------------------------------------------------------------ --

USE ROLE ROLE_HOL_LAB_DATASCIENCE;-- Deploy 

SET initial_password = '**********';

DECLARE 
    participant_name VARCHAR;
    lab_role STRING DEFAULT 'ROLE_HOL_LAB_DATASCIENCE';
BEGIN
    -- Define your array of names here
    LET participants := ARRAY_CONSTRUCT('nasko_grozdanov','corey_henschel','fabian_hernandez');

    FOR i IN 0 TO ARRAY_SIZE(participants) - 1 DO
        participant_name := participants[i];

        USE ROLE SECURITYADMIN;

        LET user_name varchar := participants[i];
        CREATE OR REPLACE USER IDENTIFIER(:user_name)
            PASSWORD = $initial_password
            DEFAULT_ROLE = :lab_role
            MUST_CHANGE_PASSWORD = FALSE;

        GRANT ROLE IDENTIFIER(:lab_role) TO USER IDENTIFIER(:user_name);

        USE ROLE ROLE_HOL_LAB_DATASCIENCE;

        -- Create participant's schema 
        let schema_name := 'HOL_LAB_DATASCIENCE.' || participant_name;        
        CREATE OR REPLACE SCHEMA IDENTIFIER(:schema_name);

        -- Create participant's stage 
        let stage_name := 'HOL_LAB_DATASCIENCE.' || participant_name || '.' || participant_name;
        CREATE OR REPLACE STAGE IDENTIFIER(:stage_name) DIRECTORY = (ENABLE = TRUE);

        -- Copy notebook
        let notebook_name := 'HOL_LAB_DATASCIENCE.' || participant_name || '.' || participant_name || '_HOL';
        CREATE OR REPLACE NOTEBOOK IDENTIFIER(:notebook_name)
         FROM '@HOL_LAB_DATASCIENCE.LAB.HOL_IFF/branches/main/'
         MAIN_FILE = 'LAB_NOTEBOOK.ipynb'
         QUERY_WAREHOUSE = WH_1_HOL_LAB_DATASCIENCE;
    END FOR;
    RETURN 'Successfully created NAMED USERS, SCHEMAS, STAGES, NOTEBOOKS';
END;

-- ------------------------------------------------------------------------------------------------------------------------ --
-- 5. SETUP NAMELESS USERS, SCHEMAS, STAGES, NOTEBOOKS (OPTIONAL) --
-- ------------------------------------------------------------------------------------------------------------------------ --


USE ROLE ROLE_HOL_LAB_DATASCIENCE;-- Deploy 

SET initial_password = '**********';
SET participant_count = 2;

DECLARE 
    i INTEGER;
    user_name VARCHAR;
    lab_role STRING DEFAULT 'ROLE_HOL_LAB_DATASCIENCE';
    user_prefix STRING DEFAULT 'LAB_USER_';
BEGIN

    FOR i IN 1 TO $participant_count DO

        LET user_name := user_prefix || i;

        USE ROLE SECURITYADMIN;

        CREATE OR REPLACE USER IDENTIFIER(:user_name)
            PASSWORD = $initial_password
            DEFAULT_ROLE = :lab_role
            MUST_CHANGE_PASSWORD = FALSE;

        GRANT ROLE IDENTIFIER(:lab_role) TO USER IDENTIFIER(:user_name);

        USE ROLE ROLE_HOL_LAB_DATASCIENCE;

        -- Create participant's schema 
        let schema_name := 'HOL_LAB_DATASCIENCE.' || user_name;        
        CREATE OR REPLACE SCHEMA IDENTIFIER(:schema_name);

        -- Create participant's stage 
        let stage_name := 'HOL_LAB_DATASCIENCE.' || user_name || '.' || user_name;
        CREATE OR REPLACE STAGE IDENTIFIER(:stage_name) DIRECTORY = (ENABLE = TRUE);

        -- Copy notebook
        let notebook_name := 'HOL_LAB_DATASCIENCE.' || user_name || '.' || user_name || '_HOL';
        CREATE OR REPLACE NOTEBOOK IDENTIFIER(:notebook_name)
         FROM '@HOL_LAB_DATASCIENCE.LAB.HOL_IFF/branches/main/'
         MAIN_FILE = 'LAB_NOTEBOOK.ipynb'
         QUERY_WAREHOUSE = WH_1_HOL_LAB_DATASCIENCE;
    END FOR;
    RETURN 'Successfully created NAMELESS USERS, SCHEMAS, STAGES, NOTEBOOKS';
END;

-- ------------------------------------------------------------------------------------------------------------------------ --
-- 6. DISABLE MFA (OPTIONAL) --
-- ------------------------------------------------------------------------------------------------------------------------ --

USE ROLE ACCOUNTADMIN;
USE DATABASE HOL_LAB_DATASCIENCE;
USE SCHEMA LAB;

CREATE AUTHENTICATION POLICY require_mfa_with_password_authentication_policy
MFA_AUTHENTICATION_METHODS = ('PASSWORD')
MFA_ENROLLMENT = OPTIONAL;

ALTER ACCOUNT SET AUTHENTICATION POLICY require_mfa_with_password_authentication_policy;
