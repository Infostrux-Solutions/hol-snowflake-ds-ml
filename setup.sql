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
USE ROLE ORGADMIN;

CREATE ORGANIZATION ACCOUNT HOL_LAB_DATASCIENCE
    ADMIN_NAME = 'FABIAN'
    ADMIN_PASSWORD = '*****'
    FIRST_NAME = 'FABIAN'
    LAST_NAME = 'HERNANDEZ'
    EMAIL = 'fabian@infostrux.com'
    MUST_CHANGE_PASSWORD = TRUE
    EDITION = 'BUSINESS_CRITICAL'
    REGION = 'AWS_US_WEST_2'
    COMMENT = 'Snowflake account for IFF HOL in Paris-March, 2025';

USE ROLE ACCOUNTADMIN;

CREATE DATABASE HOL_LAB_DATASCIENCE;

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
  
CREATE OR REPLACE ROLE ROLE_HOL_LAB_DATASCIENCE;
GRANT OWNERSHIP ON DATABASE HOL_LAB_DATASCIENCE TO ROLE ROLE_HOL_LAB_DATASCIENCE;
GRANT USAGE ON WAREHOUSE WH_1_HOL_LAB_DATASCIENCE TO ROLE ROLE_HOL_LAB_DATASCIENCE;
GRANT OPERATE ON WAREHOUSE WH_1_HOL_LAB_DATASCIENCE TO ROLE ROLE_HOL_LAB_DATASCIENCE;
GRANT USAGE ON WAREHOUSE WH_2_HOL_LAB_DATASCIENCE TO ROLE ROLE_HOL_LAB_DATASCIENCE;
GRANT OPERATE ON WAREHOUSE WH_2_HOL_LAB_DATASCIENCE TO ROLE ROLE_HOL_LAB_DATASCIENCE;
GRANT CREATE NOTEBOOK ON FUTURE SCHEMAS IN DATABASE HOL_LAB_DATASCIENCE TO ROLE ROLE_HOL_LAB_DATASCIENCE;
GRANT CREATE STREAMLIT ON FUTURE SCHEMAS IN DATABASE HOL_LAB_DATASCIENCE TO ROLE ROLE_HOL_LAB_DATASCIENCE;
GRANT CREATE MODEL ON FUTURE SCHEMAS IN DATABASE HOL_LAB_DATASCIENCE TO ROLE ROLE_HOL_LAB_DATASCIENCE;
GRANT ROLE ROLE_HOL_LAB_DATASCIENCE TO ROLE SYSADMIN;

-- User assignment.
GRANT ROLE ROLE_HOL_LAB_DATASCIENCE TO USER FABIAN;

USE ROLE ROLE_HOL_LAB_DATASCIENCE;
CREATE SCHEMA HOL_LAB_DATASCIENCE.LAB; 

USE ROLE ACCOUNTADMIN;

CREATE OR REPLACE API INTEGRATION HOL_LAB_DATASCIENCE_git_api_integration
  API_PROVIDER = git_https_api
  API_ALLOWED_PREFIXES = ('https://github.com/Infostrux-Solutions/')
  ENABLED = TRUE;

CREATE OR REPLACE GIT REPOSITORY HOL_LAB_DATASCIENCE.LAB.hol_iff
  API_INTEGRATION = HOL_LAB_DATASCIENCE_git_api_integration
  ORIGIN = 'https://github.com/Infostrux-Solutions/hol-snowflake-data-science';

CREATE OR REPLACE NETWORK RULE pypi_network_rule
  MODE = EGRESS
  TYPE = HOST_PORT
  VALUE_LIST = ('pypi.org', 'pypi.python.org', 'pythonhosted.org',  'files.pythonhosted.org');

CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION pypi_access_integration
  ALLOWED_NETWORK_RULES = (pypi_network_rule)
  ENABLED = true;


GRANT USAGE ON INTEGRATION pypi_access_integration TO ROLE ROLE_HOL_LAB_DATASCIENCE;
GRANT READ ON GIT REPOSITORY HOL_LAB_DATASCIENCE.LAB.hol_iff TO ROLE ROLE_HOL_LAB_DATASCIENCE;

USE ROLE ROLE_HOL_LAB_DATASCIENCE;-- Deploy 

-- ###### Script to setup the lab attendance schemas and notebooks.
DECLARE 
    i INTEGER;
    participant_name VARCHAR;
BEGIN
    -- Define your array of names here
    -- LET participants := ARRAY_CONSTRUCT('nasko_grozdanov','fabian_hernandez', 'corey_henschel', 'adam_nathan','akshay_goyle','alexis_blanchet','alix_pommier','bart_rijksen','boyu_niu','cassiopee_vannier','christelle_guyomard','david_bontems','kristel_ledraoullec','moamen_elsherbiny','moin_haque','niels_akeroyd','reddy_ayyalapu','yanis_penvern');

    LET participants := ARRAY_CONSTRUCT('david_bontems');

    FOR i IN 0 TO ARRAY_SIZE(participants) - 1 DO
        participant_name := participants[i];

        -- Create participant's schema 
        let schema_name := 'TRAINING_03_2025_DB.' || participant_name;        
        CREATE OR REPLACE SCHEMA IDENTIFIER(:schema_name);

        -- Create participant's stage 
        let stage_name := 'TRAINING_03_2025_DB.' || participant_name || '.' || participant_name;
        CREATE OR REPLACE STAGE IDENTIFIER(:stage_name) DIRECTORY = (ENABLE = TRUE);

        -- Copy notebook
        let notebook_name := 'TRAINING_03_2025_DB.' || participant_name || '.' || participant_name || '_HOL_03_2025';
        CREATE OR REPLACE NOTEBOOK IDENTIFIER(:notebook_name)
         FROM 'snow://notebook/TRAINING_03_2025_DB.DEMO.LAB_NOTEBOOK/versions/live/'
         MAIN_FILE = 'LAB_NOTEBOOK.ipynb'
         QUERY_WAREHOUSE = DEMO_WH;
    END FOR;
END;