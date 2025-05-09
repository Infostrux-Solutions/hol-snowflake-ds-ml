USE ROLE ACCOUNTADMIN;

-- Drop the authentication policy
DROP AUTHENTICATION POLICY IF EXISTS require_mfa_with_password_authentication_policy;

-- Reset account to default authentication policy
ALTER ACCOUNT SET AUTHENTICATION POLICY = NULL; 