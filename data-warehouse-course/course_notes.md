# Data Warehousing course - Udemy

Why do we use data warehousing? There are two sides to a business:

* Analytical decision making
  * What's the best category of X?
  * How many sales of X last month?
  * What can be improved?
* Operational data keeping
  * Receive orders
  * React to complaints
  * Fill up the stock

We have 2 categories of data processing for each side of the business:

* OLAP - Online Analytical Processing
  * Analyzing large amounts of data to extract insights and make informed decisions.
* OLTP - Online Transaction Processing
  * Processing transactions in real-time to maintain up-to-date information.

In OLTP we do one record at the time, no long history is kept.

In OLAP we use thousands or millions of records to analyze trends and patterns. We need fast query performance and we need context to understand the data over time.

Our data warehousing solutions are concerned with the analytical side of data processing.
We want to be able to derive insights from the operational data.

**Note:** How to know if a company isn't data driven or doesn't have a data warehouse?

Statements that you might hear:

* We have data but don't use it
* Our data is very complicated and difficult to analyze
* The data is not centralized
* I just want to see what is relevant!

So what is a data warehouse?
* It's a database that is optimized and used for analytical purposes.
  * User friendly, optimized for the data analysts
  * Fast query performance
  * Enable data analysis in general
  * Must load data consistently and repeatedly (ETL)


Data warehouses are created for **Business Intelligence**. What is it:

* Strategies, Procedures, Infrastructures used to create meaningful insights from data.
  * gather, store, report, visualize, and also data mining or predictive analytics

What is the difference between a data warehouse and a data lake?

* A data warehouse is a centralized repository of data from multiple sources, while a data lake is a large repository of raw data that is not structured or organized.

| **Topic** | **Data Lake** | **Data Warehouse** |
|-------|-----------|---------------|
| **Data Format** | Raw data format | Processed and refined data |
| **Schema Definition** | Schema-on-read | Schema-on-write |
| **Schema Flexibility** | Flexible schema | Fixed schema |
| **Structure** | Unstructured/semi-structured | Structured data |
| **Storage Scope** | Stores everything | Stores filtered business data |
| **Cost** | Lower cost storage | Higher cost storage |
| **Query Capability** | Complex queries possible | Optimized for analytics |
| **Primary Users** | Used by data scientists | Used by business analysts |

Data Lakes don't replace data warehouses. They complement each other.

## Data Warehouse Layers

1. Data Sources
    1. The data is in the original services, and has to be brought into the data warehouse.
    1. The data gets extracted as is.
1. Staging Area
    1. The data comes into the staging area as raw data.
    1. We leave it as untouched as possible.
    1. There can exist a "Cleansing" layer to clean the data if it's very messy.
1. Core Data layer
    1. Cleaned, transformed, structured, unified data
1. Data Mart
    1. Data Mart is a subset of the data warehouse that is optimized for a specific business function or department.
    1. Useful for better query performance, and to not be overwhelmed by all the tables that exist.
    1. We can also use specialised databases for specific performance requirements.

We can call the Data Warehouse all these layers combined, or just the layers where the data is accessed by the rest of the business (Core, Marts)
