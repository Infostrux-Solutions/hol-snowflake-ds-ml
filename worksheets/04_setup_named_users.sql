USE ROLE ROLE_HOL_LAB_DATASCIENCE;

-- TODO: Replace with desired password
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
         FROM '@HOL_LAB_DATASCIENCE.LAB.HOL/branches/main/'
         MAIN_FILE = 'LAB_NOTEBOOK.ipynb'
         QUERY_WAREHOUSE = WH_1_HOL_LAB_DATASCIENCE;
    END FOR;
    RETURN 'Successfully created NAMED USERS, SCHEMAS, STAGES, NOTEBOOKS';
END; 