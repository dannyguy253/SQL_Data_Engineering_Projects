SELECT name,
    LOWER(TRIM(name)) AS normalized_name
FROM company_dim;

-- SELECT *
-- FROM information_schema.columns
-- WHERE table_name = 'company_dim';