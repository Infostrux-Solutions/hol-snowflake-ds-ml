USE ROLE SECURITYADMIN;

DECLARE 
    participant_name VARCHAR;
BEGIN
    -- Define the same array of names as in setup
    LET participants := ARRAY_CONSTRUCT('nasko_grozdanov','corey_henschel','fabian_hernandez');

    FOR i IN 0 TO ARRAY_SIZE(participants) - 1 DO
        participant_name := participants[i];

        -- Drop the user's notebook
        DROP NOTEBOOK IF EXISTS IDENTIFIER('HOL_LAB_DATASCIENCE.' || participant_name || '.' || participant_name || '_HOL');
        
        -- Drop the user's stage
        DROP STAGE IF EXISTS IDENTIFIER('HOL_LAB_DATASCIENCE.' || participant_name || '.' || participant_name);
        
        -- Drop the user's schema
        DROP SCHEMA IF EXISTS IDENTIFIER('HOL_LAB_DATASCIENCE.' || participant_name);
        
        -- Drop the user
        DROP USER IF EXISTS IDENTIFIER(participant_name);
    END FOR;
    RETURN 'Successfully removed NAMED USERS, SCHEMAS, STAGES, NOTEBOOKS';
END; 