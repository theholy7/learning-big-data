# Introduction to Data Engineering

This document will contain the questions and answers around basic data engineering concepts, that are normally asked
during an interview process. It is a live document that will be updated in the future.

# Table of Contents

## Database Fundamentals
* What is ACID?
* What is partitioning or sharding?
* What is the difference between a columnar and a row-oriented database?
* What is the difference between a primary key and a foreign key?

## Data Modeling
* What is the difference between a Fact and a Dimension table?
* What is a Slow Changing Dimension?
* What is the second normal form?
* What are techniques to ensure data quality and integrity?
* What is the difference between star schema and snowflake schema?
* What is normalization and denormalization in database design?

## Data Storage and Processing
* What is a Delta Table?
* What is a time travel query?
* What is the different levels of medallion architecture?
* What is the difference between avro and parquet?

## DevOps and MLOps
* What is the difference between mlops and devops?


# Database Fundamentals

TODO:

* What is ACID?
* What is partitioning or sharding?

### What is the difference between a columnar and a row-oriented database?

In row-oriented databases (like PostgreSQL, MySQL, SQLite):

* Data is stored row by row, with all columns of a single record physically adjacent
* Optimized for OLTP (Online Transaction Processing) workloads
* Efficient for operations that access complete records (inserts, updates, deletes)
* Good for point queries retrieving specific records
* Less efficient for analytical queries that scan large portions of specific columns

In columnar databases (like BigQuery, Redshift, Snowflake, ClickHouse):

* Data is stored column by column, with all values of a single column physically adjacent
* Optimized for OLAP (Online Analytical Processing) workloads
* Highly efficient for aggregations and scans across specific columns
* Better compression ratios since similar data is stored together
* Vectorized operations can be applied to entire columns
* Slower for record-level operations (inserts, updates)

### What is the difference between a primary key and a foreign key?

A primary key is a column or a set of columns that uniquely identifies each row in a table.
It is used to enforce data integrity and ensure that each row is unique.

A foreign key is a column or a set of columns that references the primary key of another table.
It is used to establish relationships between tables and ensure data consistency.

# Data Modeling

TODO:

* What is the difference between a Fact and a Dimension table?
* What is a Slow Changing Dimension?
* what is the second normal form
* What are techniques to ensure data quality and integrity?

### What is the difference between star schema and snowflake schema?

Star schema is a simple data model that consists of a central fact table and multiple dimension tables.
Attached to the main central fact table are multiple dimension tables.
The data stored is

Snowflake schema is a more complex data model that consists of multiple fact and dimension tables.
There is less data repetition compared to the star schema, making it more efficient for large datasets.

### What is normalization and denormalization in database design?

Normalization is the process of organizing data according to normsl in a database.
We have "norms" that establish the relationships between tables and data points.
Denormalization is the process of organizing data in a database to improve query performance and reduce the number of joins - this means that some data gets duplicated.

# Data Storage and Processing

TODO:

* What is a Delta Table?
* What is a time travel query?

### What is the different levels of medallion architecture?

Medallion architecture is a data design pattern used to logically organize data in a lakehouse.
It incrementally and progressively improves the structure and quality of the data as it flows through each level.
The levels are: Bronze, Silver, Gold.
Sometimes they are called "multi-hop" architecture.

### What is the difference between avro and parquet?

Parquet is a columnar storage format, and Avro is a row-based storage format.

Parquet is a big data storage format that allows for nested data structures and is very efficient
for data compression and storage.

Avro is a data serialization format that is used for storing and transmitting data in a compact and efficient manner.
It stores the schema information along with the data, and allows the data being sent to any destination and be processed.

# DevOps and MLOps

### What is the difference betwwen mlops and devops?

The phases of MLOps are: the Experimental Phase, and the Production Phase.

In the Experimental Phase we consider:
* Problem identificaiton, data collection and analysis
* ML model selection and development
* Data experimentation and model training

Then in the Production Phase we consider:
* Data validation and quality control
* Model deployment and monitoring
* Model updates and retraining

The stages of DevOps are:
* Development
* Testing
* Deployment
* Monitoring

MLOps is used to develop, deploy and monitor machine learning models, and DevOps is used to develop, deploy and monitor software applications.
