# Data Warehouse course

The data warehousing course did not specify a tool to use. The concepts were generic enough that they could be
applied using any tool or framework.

To complete the course I have attempted to use `dbt` - data build tool.

There are however some caveats on how we should think about the implementation of the data warehouse using `dbt`.

## Notes

### Surrogate Keys

**Hashes** vs **Sequences**

_todo expand on the subject_
https://docs.getdbt.com/blog/managing-surrogate-keys
https://www.getdbt.com/blog/guide-to-surrogate-key
https://docs.getdbt.com/blog/sql-surrogate-keys

How to deal with incremental data
