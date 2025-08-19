# Queries and Output

## Query 1: Data Sample Validation Count 

This statement validates that we successfully inserted 3 rows per table.

<details>
  <summary>Show Query 1 and Output</summary>

  ```sql
SELECT 
    CASE 
        WHEN COUNT(*) = 0 THEN 'All tables have >= 3 rows'
        ELSE 'Some tables have fewer than 3 rows'
    END AS `Insert Check`
FROM information_schema.tables
WHERE table_schema = 'dbms_project'
  AND table_rows < 3;
```

<img width="219" height="66" alt="image" src="https://github.com/user-attachments/assets/c831a692-3111-4d71-9acb-26bf606363b0" />

</details>

