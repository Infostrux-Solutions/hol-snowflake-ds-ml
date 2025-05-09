USE ROLE SECURITYADMIN;

DECLARE 
    i INTEGER;
    user_name VARCHAR;
    user_prefix STRING DEFAULT 'LAB_USER_';
    participant_count INTEGER DEFAULT 2;
BEGIN
    FOR i IN 1 TO participant_count DO
        LET user_name := user_prefix || i;

        -- Drop the user's notebook
        DROP NOTEBOOK IF EXISTS IDENTIFIER('HOL_LAB_DATASCIENCE.' || user_name || '.' || user_name || '_HOL');
        
        -- Drop the user's stage
        DROP STAGE IF EXISTS IDENTIFIER('HOL_LAB_DATASCIENCE.' || user_name || '.' || user_name);
        
        -- Drop the user's schema
        DROP SCHEMA IF EXISTS IDENTIFIER('HOL_LAB_DATASCIENCE.' || user_name);
        
        -- Drop the user
        DROP USER IF EXISTS IDENTIFIER(user_name);
    END FOR;
    RETURN 'Successfully removed NAMELESS USERS, SCHEMAS, STAGES, NOTEBOOKS';
END; 