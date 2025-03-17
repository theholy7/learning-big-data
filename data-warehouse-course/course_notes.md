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

### Why is it good to have a staging area?

1. We don't want to slow operational systems down - we want a quick extract;
1. We want to have the data available for analysis;
1. We can transform the data in the staging area without fear

There are 2 types of staging areas:

1. Temporary staging area
1. Persistant staging area

**We can have a temporary staging area:**

We need to be able to extract data, and then understand what is the new data to extract it. For example using an ID column, to identify the new data. We can apply our logic again, and then append data to our tables that already contain data.

**We can have a persistant staging area:**

Persistant layer would always have all the data, but it is more rare.

In practice, we usually have all the layers in a single database. We use schemas to contain the different layers.

For example, in PostgreSQL, the `public` schema is the default schema. We can create multiple different schemas for our needs.

## Data Marts

Normally, the Core layer is the access layer for the organizations.
However, in large organizations, we might add a Data Mart layer on top of the Core layer.
It represents a subset of the data warehouse that is optimized for a specific business function or department.
It has fact tables in the middle, and dimension tables on the sides.

**Benefits of data marts**:

1. Usability & Acceptance - we just focus on the relevant data, and users have an easier time
1. Performance - Data is modelled in a dimensional way, and we can use specific tools
    1. In-memory databases
    1. Dimensional cubes

Use-cases, in practice:

1. Different tools using the data warehouse, i.e. data visualization tools, predictive analytics tools
1. Different departments using the data warehouse, i.e. marketing, sales, finance
1. Different regions using the warehouse, i.e. North America, Europe, Asia

## Data warehouse technologies

### Relational databases

1. Data is stored as relations (tables)
    1. Primary keys and Foreign keys to establish relationships

The classics: PostgreSQL, MySQL, etc

### In-memory databases

1. Highly optimized for query performance
    1. Commonly used for data marts
    1. Good for analytics, high query volume
    1. Can be relational or non-relational
    1. Can have columnar storage
    1. Can allow parallel query plans
1. Durability - all data is lost when device loses power or resets
    1. We can use snapshots/images to add some durability
1. Cost-factor
    1. Try to lower the cost by only loading the required data

Examples of these are: Amazon MemoryDB, Redis,...

### OLAP Cubes

A method to try to increase the performance of the data mart.
What are they, and what is their role?

Data is organized in a non-relational way in Cube (MOLAP), organized into dimensions. Cube is a multidemensional dataset.

Main reason to use cubes is for analytical purposes for fast and efficient performance.

Imagine, we want to analyze Products, Time, and Customers, to understand Sales data. We use the intersection of these dimentions to create the result. We can precalculate the intersections that exist for all these vectors (Product, Time, Customers).

The most commonly used language for these cubes is MDX. We get high performance because the data is precalculated and stored in a multidimensional format.

**Recommendations:**

1. Use for specific use-cases, and don't use a very high number of dimensions
1. Good for interactice queries with hierarchies
1. They are optional, you are not forced to use them. Think about them after the star schema.

They are less important today, as the hardware has improved significantly. For example, columnar storage tools are very fast.

## ODS - Operational Data Storage

Goal: clear the definition between data warehouse and ODS.

ODS is a data storage solution for operational decision making. We perform ETL to load data into the ODS.

* No long data history
* Needs to be very current or almost real-time

Example: Should we give this customer a credit?

* We need to have the data in near real-time to make this decision

You can have both an ODS and a Data Warehouse in your company. It can be both a parallel or a sequential approach. Services -> ODS -> Data Warehouse, or Services -> ODS, Services -> Data Warehouse.

ODS' are getting more irrelevant because of better technologies and software.

## Summary:

* Staging
    * Landing
    * Minimal transformation
    * Stage data in tables
* Core
    * Always present
    * Business logic & source of truth
    * Can be access layer
* Mart
    * Access layer
    * Specific for use-cases
    * Optimized for performance
