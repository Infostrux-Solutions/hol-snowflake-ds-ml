USE ROLE ROLE_HOL_LAB_DATASCIENCE;

-- TODO: Replace with desired password and adjust participant_count based on number of attendees
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
         FROM '@HOL_LAB_DATASCIENCE.LAB.HOL/branches/main/'
         MAIN_FILE = 'LAB_NOTEBOOK.ipynb'
         QUERY_WAREHOUSE = WH_1_HOL_LAB_DATASCIENCE;
    END FOR;
    RETURN 'Successfully created NAMELESS USERS, SCHEMAS, STAGES, NOTEBOOKS';
END; 