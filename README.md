# SQL-request

Common sql queries for [Prestashop](https://www.prestashop.com/).

## Disclaimer

These queries are intended for developers who knows that interacting with a database can cause non reversible troubles.

Be sure to have a backup of the database you interact with and to know what the queries do.

_Friends of Presta_ cannot be held responsible for any damage caused by running this queries.

We decided to use the default database prefix (`ps_`) for the SQL requests, but for security reasons we strongly recommend to customize your database prefix instead of using the default one especially in production.
Changing it will help protect your shop against any attacks (some SQL injection for example) targeting the default table names.
You can change the default database prefix with this SQL request https://github.com/friends-of-presta/SQL-request/blob/main/1.7/maintenance/rename_table_prefix.sql use this request at your own risk. If you customize the default database prefix you need to change it in `/app/config/parameters.php`


