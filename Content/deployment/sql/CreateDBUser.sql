CREATE USER [<%PROJECT_HYPHENATED_NAME%>.www] WITH PASSWORD = '<%ENV_PASS%>' 
GO

EXEC sp_addrolemember N'db_owner', N'<%PROJECT_HYPHENATED_NAME%>.www'
GO
