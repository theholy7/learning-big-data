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


# Dimensional Modeling

It is a methods of organizing data.
We will learn about:

* Facts
    * Something that can be measured, profit
* Dimensions
    * Context, like a period, like a year

With these tables we can turn the measure and the context into an insight, i.e. profit per year.

A Star Schema has facts in the middle and dimensions around it.
It is a unique technique to structure data, optimized for faster data retrieval.
Oriented around performance and usability, and designed for reporting / OLAP.

## Facts Tables

**Definition**

* The key measurements of a company
* Facts get aggregated and analyzed

What is a fact usually?

* Aggregatable (numerical values)
    * They make sense when aggregated e.g. the total amount of sold units
* Measureble, not descriptive
* Event, or transactional data
    * a sale, a profile view, etc
* Date/Time in a fact table
    * when the fact happened

**Detailed**

* Normally is:
    * Characteristics:
        * Primary Key
        * Multiple Foreign Keys - reference to dimensions
        * Fact itself
    * Grain:
        * most atomic level facts are defined
        * every region, at every date, etc etc
    * Different types of facts:
        * Defined later on



## Dimensions Tables


**Definition**

* Categorizes the facts
* Supportive and descriptive
* Filter, group and labeling the data
    * Slicing and dicing

Common characteristics:
* Non-aggregatable
* Descriptive
* More Static normally

**Detailed**

* Dimension table:
    * Characteristics:
        * Primary Key
        * Foreign Keys - reference to other dimensions
        * Descriptive attributes
    * Type
        * People
        * Products
        * places
        * times
    * Different types of dimensions:
        * Slowly changing dimensions
        * Discussed later on

## Schemas

### Star Schema

The most important schema in a data warehouse or data mart.
The facts are in the middle, surrounded by dimensions.
Normally a single value of the dimension has many facts that use it.
For example, multiple sales might be of vegetable category `Root Vegetable`.

In Dimensions we might have data redundancy. Values can be duplicated, for example, a dimension for `garlic` and
`banana` might be under the category `fruits and vegetables`. This is optimized to get data out, better for read queires. Essentially, the table is **denormalized**.

We sometimes might have multiple fact tables. We have to define a grain for each fact table.

* Most common schema in data mart
* Simplest form vs snowflake schema
* Works best for specific needs

### Snowflake Schema

Star schema is a special case of snowflake schema.
Snowflake schema is a more normalized version of star schema.
We essentially get multiple levels of dimensions.

Advantage:
* Less space taken (lower storage cost)
* Less redundant data (easier to update / maintain)
* solves write slowdowns

Disadvantage:
* More complex to query
* More joins required
* Less performance for Data Mart / cubes

Modelling with Star Schema is more common for both the Core DW and the Data Mart.


## Dimensional Modeling Exercise

**Question**

Transform the following schema into a data warehouse schema:

| **SalesTransactions** |
|--------------------|
| TransactionID      |
| Date              |
| Quantity          |
| TransactionAmount |
| Item ID           |
| Item Name         |
| Brand name        |
| Category_name     |
| Location ID       |
| Country           |
| State             |
| City              |
| Location_manager  |

**Answer**

| **Fact_Sales** |             |
|---------------|-------------|
| TransactionID | Primary Key |
| DateID        | Foreign Key |
| ItemID        | Foreign Key |
| LocationID    | Foreign Key |
| ManagerID     | Foreign Key |
| Quantity      |             |
| TransactionAmount |         |

| **Dim_Date** |             |
|--------------|-------------|
| DateID       | Primary Key |
| ISODate      |             |
| DayOfWeek    |             |
| DayOfMonth   |             |
| Month        |             |
| Year         |             |
| Quarter      |             |
| IsWeekend    |             |
| IsHoliday    |             |

| **Dim_Item** |             |
|--------------|-------------|
| ItemID       | Primary Key |
| ItemName     |             |
| BrandName    |             |
| CategoryName |             |

| **Dim_Location** |             |
|-----------------|-------------|
| LocationID      | Primary Key |
| Country         |             |
| State           |             |
| City            |             |

| **Dim_Manager** |             |
|----------------|-------------|
| ManagerID      | Primary Key |
| ManagerName    |             |
