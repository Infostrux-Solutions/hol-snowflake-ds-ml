SET ROW_COUNT = 5000;

CREATE OR REPLACE TABLE HOL_LAB_DATASCIENCE.LAB.CLUSTER_QUALIFICATION AS
SELECT * 
FROM (
    SELECT 
        'Control Freak' AS CLUSTER,
        ROUND(LEAST(GREATEST(normal(9, 1, random()), 0), 10)) AS CM_OWN_WAY,
        ROUND(LEAST(GREATEST(normal(9, 1, random()), 0), 10)) AS CM_SECURE_SURROUNDINGS,
        ROUND(LEAST(GREATEST(normal(3, 1, random()), 0), 10)) AS CM_GOOD_TIME,
        ROUND(LEAST(GREATEST(normal(10, 1, random()), 0), 10)) AS CM_FOLLOW_RULES,
        ROUND(LEAST(GREATEST(normal(2, 1, random()), 0), 10)) AS CM_DIFFERENT_PEOPLE,
        ROUND(LEAST(GREATEST(normal(6, 1, random()), 0), 10)) AS CM_SATISFACTION,
        ROUND(LEAST(GREATEST(normal(9, 1, random()), 0), 10)) AS CM_SUCCESSFUL,
        ROUND(LEAST(GREATEST(normal(7, 1, random()), 0), 10)) AS CM_DEVOTE_MYSELF,
        ROUND(LEAST(GREATEST(normal(2, 1, random()), 0), 10)) AS CM_TAKE_RISKS,
        ROUND(LEAST(GREATEST(normal(9, 1, random()), 0), 10)) AS CM_BE_IN_CHARGE
    FROM table(generator(rowCount => $ROW_COUNT))

    UNION ALL

    SELECT 
        'Good Friend' AS CLUSTER,
        ROUND(LEAST(GREATEST(normal(4, 1, random()), 0), 10)) AS CM_OWN_WAY,
        ROUND(LEAST(GREATEST(normal(8, 1, random()), 0), 10)) AS CM_SECURE_SURROUNDINGS,
        ROUND(LEAST(GREATEST(normal(8, 1, random()), 0), 10)) AS CM_GOOD_TIME,
        ROUND(LEAST(GREATEST(normal(7, 1, random()), 0), 10)) AS CM_FOLLOW_RULES,
        ROUND(LEAST(GREATEST(normal(9, 1, random()), 0), 10)) AS CM_DIFFERENT_PEOPLE,
        ROUND(LEAST(GREATEST(normal(9, 1, random()), 0), 10)) AS CM_SATISFACTION,
        ROUND(LEAST(GREATEST(normal(5, 1, random()), 0), 10)) AS CM_SUCCESSFUL,
        ROUND(LEAST(GREATEST(normal(6, 1, random()), 0), 10)) AS CM_DEVOTE_MYSELF,
        ROUND(LEAST(GREATEST(normal(3, 1, random()), 0), 10)) AS CM_TAKE_RISKS,
        ROUND(LEAST(GREATEST(normal(3, 1, random()), 0), 10)) AS CM_BE_IN_CHARGE
    FROM table(generator(rowCount => $ROW_COUNT))

    UNION ALL

    SELECT 
        'Explorer' AS CLUSTER,
        ROUND(LEAST(GREATEST(normal(8, 1, random()), 0), 10)) AS CM_OWN_WAY,
        ROUND(LEAST(GREATEST(normal(3, 1, random()), 0), 10)) AS CM_SECURE_SURROUNDINGS,
        ROUND(LEAST(GREATEST(normal(9, 1, random()), 0), 10)) AS CM_GOOD_TIME,
        ROUND(LEAST(GREATEST(normal(2, 1, random()), 0), 10)) AS CM_FOLLOW_RULES,
        ROUND(LEAST(GREATEST(normal(10, 1, random()), 0), 10)) AS CM_DIFFERENT_PEOPLE,
        ROUND(LEAST(GREATEST(normal(7, 1, random()), 0), 10)) AS CM_SATISFACTION,
        ROUND(LEAST(GREATEST(normal(6, 1, random()), 0), 10)) AS CM_SUCCESSFUL,
        ROUND(LEAST(GREATEST(normal(5, 1, random()), 0), 10)) AS CM_DEVOTE_MYSELF,
        ROUND(LEAST(GREATEST(normal(9, 1, random()), 0), 10)) AS CM_TAKE_RISKS,
        ROUND(LEAST(GREATEST(normal(4, 1, random()), 0), 10)) AS CM_BE_IN_CHARGE
    FROM table(generator(rowCount => $ROW_COUNT))

    UNION ALL

    SELECT 
        'Skeptic' AS CLUSTER,
        ROUND(LEAST(GREATEST(normal(5, 1, random()), 0), 10)) AS CM_OWN_WAY,
        ROUND(LEAST(GREATEST(normal(9, 1, random()), 0), 10)) AS CM_SECURE_SURROUNDINGS,
        ROUND(LEAST(GREATEST(normal(3, 1, random()), 0), 10)) AS CM_GOOD_TIME,
        ROUND(LEAST(GREATEST(normal(9, 1, random()), 0), 10)) AS CM_FOLLOW_RULES,
        ROUND(LEAST(GREATEST(normal(4, 1, random()), 0), 10)) AS CM_DIFFERENT_PEOPLE,
        ROUND(LEAST(GREATEST(normal(5, 1, random()), 0), 10)) AS CM_SATISFACTION,
        ROUND(LEAST(GREATEST(normal(7, 1, random()), 0), 10)) AS CM_SUCCESSFUL,
        ROUND(LEAST(GREATEST(normal(6, 1, random()), 0), 10)) AS CM_DEVOTE_MYSELF,
        ROUND(LEAST(GREATEST(normal(2, 1, random()), 0), 10)) AS CM_TAKE_RISKS,
        ROUND(LEAST(GREATEST(normal(6, 1, random()), 0), 10)) AS CM_BE_IN_CHARGE
    FROM table(generator(rowCount => $ROW_COUNT))

    UNION ALL

    SELECT 
        'Power User' AS CLUSTER,
        ROUND(LEAST(GREATEST(normal(9, 1, random()), 0), 10)) AS CM_OWN_WAY,
        ROUND(LEAST(GREATEST(normal(6, 1, random()), 0), 10)) AS CM_SECURE_SURROUNDINGS,
        ROUND(LEAST(GREATEST(normal(6, 1, random()), 0), 10)) AS CM_GOOD_TIME,
        ROUND(LEAST(GREATEST(normal(5, 1, random()), 0), 10)) AS CM_FOLLOW_RULES,
        ROUND(LEAST(GREATEST(normal(7, 1, random()), 0), 10)) AS CM_DIFFERENT_PEOPLE,
        ROUND(LEAST(GREATEST(normal(8, 1, random()), 0), 10)) AS CM_SATISFACTION,
        ROUND(LEAST(GREATEST(normal(10, 1, random()), 0), 10)) AS CM_SUCCESSFUL,
        ROUND(LEAST(GREATEST(normal(9, 1, random()), 0), 10)) AS CM_DEVOTE_MYSELF,
        ROUND(LEAST(GREATEST(normal(7, 1, random()), 0), 10)) AS CM_TAKE_RISKS,
        ROUND(LEAST(GREATEST(normal(8, 1, random()), 0), 10)) AS CM_BE_IN_CHARGE
    FROM table(generator(rowCount => $ROW_COUNT))

    UNION ALL

    SELECT 
        'Minimalist' AS CLUSTER,
        ROUND(LEAST(GREATEST(normal(7, 1, random()), 0), 10)) AS CM_OWN_WAY,
        ROUND(LEAST(GREATEST(normal(8, 1, random()), 0), 10)) AS CM_SECURE_SURROUNDINGS,
        ROUND(LEAST(GREATEST(normal(4, 1, random()), 0), 10)) AS CM_GOOD_TIME,
        ROUND(LEAST(GREATEST(normal(7, 1, random()), 0), 10)) AS CM_FOLLOW_RULES,
        ROUND(LEAST(GREATEST(normal(3, 1, random()), 0), 10)) AS CM_DIFFERENT_PEOPLE,
        ROUND(LEAST(GREATEST(normal(8, 1, random()), 0), 10)) AS CM_SATISFACTION,
        ROUND(LEAST(GREATEST(normal(6, 1, random()), 0), 10)) AS CM_SUCCESSFUL,
        ROUND(LEAST(GREATEST(normal(5, 1, random()), 0), 10)) AS CM_DEVOTE_MYSELF,
        ROUND(LEAST(GREATEST(normal(3, 1, random()), 0), 10)) AS CM_TAKE_RISKS,
        ROUND(LEAST(GREATEST(normal(5, 1, random()), 0), 10)) AS CM_BE_IN_CHARGE
    FROM table(generator(rowCount => $ROW_COUNT))

    UNION ALL

    SELECT 
        'Helper' AS CLUSTER,
        ROUND(LEAST(GREATEST(normal(3, 1, random()), 0), 10)) AS CM_OWN_WAY,
        ROUND(LEAST(GREATEST(normal(9, 1, random()), 0), 10)) AS CM_SECURE_SURROUNDINGS,
        ROUND(LEAST(GREATEST(normal(7, 1, random()), 0), 10)) AS CM_GOOD_TIME,
        ROUND(LEAST(GREATEST(normal(8, 1, random()), 0), 10)) AS CM_FOLLOW_RULES,
        ROUND(LEAST(GREATEST(normal(10, 1, random()), 0), 10)) AS CM_DIFFERENT_PEOPLE,
        ROUND(LEAST(GREATEST(normal(10, 1, random()), 0), 10)) AS CM_SATISFACTION,
        ROUND(LEAST(GREATEST(normal(6, 1, random()), 0), 10)) AS CM_SUCCESSFUL,
        ROUND(LEAST(GREATEST(normal(9, 1, random()), 0), 10)) AS CM_DEVOTE_MYSELF,
        ROUND(LEAST(GREATEST(normal(4, 1, random()), 0), 10)) AS CM_TAKE_RISKS,
        ROUND(LEAST(GREATEST(normal(4, 1, random()), 0), 10)) AS CM_BE_IN_CHARGE
    FROM table(generator(rowCount => $ROW_COUNT))

    UNION ALL

    SELECT 
        'Achiever' AS CLUSTER,
        ROUND(LEAST(GREATEST(normal(8, 1, random()), 0), 10)) AS CM_OWN_WAY,
        ROUND(LEAST(GREATEST(normal(7, 1, random()), 0), 10)) AS CM_SECURE_SURROUNDINGS,
        ROUND(LEAST(GREATEST(normal(6, 1, random()), 0), 10)) AS CM_GOOD_TIME,
        ROUND(LEAST(GREATEST(normal(6, 1, random()), 0), 10)) AS CM_FOLLOW_RULES,
        ROUND(LEAST(GREATEST(normal(6, 1, random()), 0), 10)) AS CM_DIFFERENT_PEOPLE,
        ROUND(LEAST(GREATEST(normal(9, 1, random()), 0), 10)) AS CM_SATISFACTION,
        ROUND(LEAST(GREATEST(normal(10, 1, random()), 0), 10)) AS CM_SUCCESSFUL,
        ROUND(LEAST(GREATEST(normal(9, 1, random()), 0), 10)) AS CM_DEVOTE_MYSELF,
        ROUND(LEAST(GREATEST(normal(6, 1, random()), 0), 10)) AS CM_TAKE_RISKS,
        ROUND(LEAST(GREATEST(normal(9, 1, random()), 0), 10)) AS CM_BE_IN_CHARGE
    FROM table(generator(rowCount => $ROW_COUNT))

    UNION ALL

    SELECT 
        'Frustrated Newbie' AS CLUSTER,
        ROUND(LEAST(GREATEST(normal(2, 1, random()), 0), 10)) AS CM_OWN_WAY,
        ROUND(LEAST(GREATEST(normal(7, 1, random()), 0), 10)) AS CM_SECURE_SURROUNDINGS,
        ROUND(LEAST(GREATEST(normal(5, 1, random()), 0), 10)) AS CM_GOOD_TIME,
        ROUND(LEAST(GREATEST(normal(5, 1, random()), 0), 10)) AS CM_FOLLOW_RULES,
        ROUND(LEAST(GREATEST(normal(5, 1, random()), 0), 10)) AS CM_DIFFERENT_PEOPLE,
        ROUND(LEAST(GREATEST(normal(4, 1, random()), 0), 10)) AS CM_SATISFACTION,
        ROUND(LEAST(GREATEST(normal(3, 1, random()), 0), 10)) AS CM_SUCCESSFUL,
        ROUND(LEAST(GREATEST(normal(2, 1, random()), 0), 10)) AS CM_DEVOTE_MYSELF,
        ROUND(LEAST(GREATEST(normal(2, 1, random()), 0), 10)) AS CM_TAKE_RISKS,
        ROUND(LEAST(GREATEST(normal(3, 1, random()), 0), 10)) AS CM_BE_IN_CHARGE
    FROM table(generator(rowCount => $ROW_COUNT))

    UNION ALL

    SELECT 
        'Passive User' AS CLUSTER,
        ROUND(LEAST(GREATEST(normal(3, 1, random()), 0), 10)) AS CM_OWN_WAY,
        ROUND(LEAST(GREATEST(normal(6, 1, random()), 0), 10)) AS CM_SECURE_SURROUNDINGS,
        ROUND(LEAST(GREATEST(normal(6, 1, random()), 0), 10)) AS CM_GOOD_TIME,
        ROUND(LEAST(GREATEST(normal(5, 1, random()), 0), 10)) AS CM_FOLLOW_RULES,
        ROUND(LEAST(GREATEST(normal(4, 1, random()), 0), 10)) AS CM_DIFFERENT_PEOPLE,
        ROUND(LEAST(GREATEST(normal(5, 1, random()), 0), 10)) AS CM_SATISFACTION,
        ROUND(LEAST(GREATEST(normal(4, 1, random()), 0), 10)) AS CM_SUCCESSFUL,
        ROUND(LEAST(GREATEST(normal(3, 1, random()), 0), 10)) AS CM_DEVOTE_MYSELF,
        ROUND(LEAST(GREATEST(normal(2, 1, random()), 0), 10)) AS CM_TAKE_RISKS,
        ROUND(LEAST(GREATEST(normal(2, 1, random()), 0), 10)) AS CM_BE_IN_CHARGE
    FROM table(generator(rowCount => $ROW_COUNT))
) 
ORDER BY random();