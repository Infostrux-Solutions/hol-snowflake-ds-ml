
USE ROLE ROLE_HOL_LAB_DATASCIENCE;-- Deploy 

SET initial_password = 'verum ipsum factum';

DECLARE 
    participant_name VARCHAR;
    lab_role STRING DEFAULT 'ROLE_HOL_LAB_DATASCIENCE';
BEGIN
    -- Define your array of names here
    LET participants := ARRAY_CONSTRUCT('abhishek_basu','sean_murphy','jeffrey_wu','sarah_rich','whitney_hawkins','bin_mao','ersi_hodo','christopher_madsen','mark_gordon','elliot_kardon','alison_hoi','eliza_tadley','josh_daghlian','jordan_morgan','mayur_sharma','anurag_gandhi','hannah_yi','katelyn_mcnab','alex_kotsakis','jason_prentice','fivos_kanellis','tanner_muro','andrew_rogers','raghu_mulukutla','taiseer_rahman','yash_nema','jiaxin_lyu','randy_dupre','ian_tarr');

    FOR i IN 0 TO ARRAY_SIZE(participants) - 1 DO
        participant_name := participants[i];

        

        LET user_name varchar := participants[i];
        

        USE ROLE ROLE_HOL_LAB_DATASCIENCE;

        -- Copy notebook
        let notebook_name := 'HOL_LAB_DATASCIENCE.' || participant_name || '.' || participant_name || '_HOL';
        DROP NOTEBOOK IDENTIFIER(:notebook_name);

        -- Create participant's stage 
        let stage_name := 'HOL_LAB_DATASCIENCE.' || participant_name || '.' || participant_name;
        DROP STAGE IDENTIFIER(:stage_name);
      

        -- Create participant's schema 
        let schema_name := 'HOL_LAB_DATASCIENCE.' || participant_name;        
        DROP SCHEMA IDENTIFIER(:schema_name);


        -- USE ROLE SECURITYADMIN;
        
        -- DROP USER IDENTIFIER(:user_name);

        
    END FOR;
    RETURN 'Successfully dropped NAMED USERS, SCHEMAS, STAGES, NOTEBOOKS';
END;