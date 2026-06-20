SELECT *
FROM company_dim
LIMIT 10;

SELECT name, UPPER(name) AS standardized_company_name
FROM company_dim
ORDER BY standardized_company_name;