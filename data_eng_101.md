# Introduction to Data Engineering

This document will contain the questions and answers around basic data engineering concepts, that are normally asked
during an interview process. It is a live document that will be updated in the future.

# Questions in document

* What are techniques to ensure data quality and integrity?
* What is ACID?
* What is a Delta Table?
* What is a Slow Changing Dimension?
* What is a time travel query?
* What is partitioning or sharding?
* What is the difference between a Fact and a Dimension table?
* What is the difference between a columnar and a row-oriented database?
* What is Redis, and what are it's advantages?

**What is the different levels of medallion architecture?**
Medallion architecture is a data design pattern used to logically organize data in a lakehouse.
It incrementally and progressively improves the structure and quality of the data as it flows through each level.
The levels are: Bronze, Silver, Gold.
Sometimes they are called "multi-hop" architecture.

**What is the difference between a primary key and a foreign key?**
A primary key is a column or a set of columns that uniquely identifies each row in a table.
It is used to enforce data integrity and ensure that each row is unique.

A foreign key is a column or a set of columns that references the primary key of another table.
It is used to establish relationships between tables and ensure data consistency.

**What is the difference between star schema and snowflake schema?**

Star schema is a simple data model that consists of a central fact table and multiple dimension tables.
Attached to the main central fact table are multiple dimension tables.
The data stored is

Snowflake schema is a more complex data model that consists of multiple fact and dimension tables.
There is less data repetition compared to the star schema, making it more efficient for large datasets.

**What is normalization and denormalization in database design?**

Normalization is the process of organizing data according to normsl in a database.
We have "norms" that establish the relationships between tables and data points.
Denormalization is the process of organizing data in a database to improve query performance and reduce the number of joins - this means that some data gets duplicated.

* what is the difference between avro and parquet
* what is the difference betwwen mlops and devops
* What are the stages of mlops
* what are the stages of devops
* what is the second normal form
