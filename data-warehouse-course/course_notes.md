# Table of Contents

* [Data Warehousing course - Udemy](#data-warehousing-course---udemy)
  * [Data Warehouse Layers](#data-warehouse-layers)
    * [Why is it good to have a staging area?](#why-is-it-good-to-have-a-staging-area)
  * [Data Marts](#data-marts)
  * [Data warehouse technologies](#data-warehouse-technologies)
    * [Relational databases](#relational-databases)
    * [In-memory databases](#in-memory-databases)
    * [OLAP Cubes](#olap-cubes)
  * [ODS - Operational Data Storage](#ods---operational-data-storage)
  * [Summary](#summary)
* [Dimensional Modeling](#dimensional-modeling)
  * [Facts Tables](#facts-tables)
  * [Dimensions Tables](#dimensions-tables)
  * [Schemas](#schemas)
    * [Star Schema](#star-schema)
    * [Snowflake Schema](#snowflake-schema)
  * [Dimensional Modeling Exercise](#dimensional-modeling-exercise)
* [Facts in depth](#facts-in-depth)
  * [Additivity](#additivity)
  * [Nulls](#nulls)
  * [Year-to-date facts](#year-to-date-facts)
  * [Types of fact tables](#types-of-fact-tables)
    * [Transactional fact tables](#transactional-fact-tables)
    * [Periodic Snapshot fact tables](#periodic-snapshot-fact-tables)
    * [Accumulating fact tables](#accumulating-fact-tables)
    * [Summary of Fact Tables](#summary-of-fact-tables)
    * [Special: Factless Fact Table](#special-factless-fact-table)
    * [Fact table design](#fact-table-design)
    * [Natural vs surrogate keys](#natural-vs-surrogate-keys)
* [Dimensions in depth](#dimensions-in-depth)


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


# Facts in depth

## Additivity

* Additive
    * added across all dimentions
    * Sum all sales across all dimensions, like category, or name, etc
* Semi-additive
    * added across a few
    * Account balance, it does not make sense to add across all dimensions for example date
        * The value at the last date is the actual value, not the sum of all previous dates
    * However we can across all the portfolio IDs for example. Total amount for all portfolios for a date
    * Be careful when using these facts, explore alternatives like averaging
* Non-additive
    * The price of a unit is not additive, it depends on the quantity
    * We would not get a meaningful value out of summing up the prices of individual items across dimensions
    * Prices, percentages, rations, etc are not additive
    * If there is a ration, you could store the underlying values for example.
      * this would give you the most analytical value out of those values

## Nulls

* Sometimes having nulls is not an issue. SQL handles them easily.
* We need to pay attention to nulls vs zeroes for example
    * Sometimes it makes sense to replace the nulls with zeroes
* We need to really pay attention to nulls present in Foreign Keys
    * Nulls in Foreign Keys can cause issues with joins and aggregations
    * We can use a special value like -1 or 999 and we add a value to the dimension table
    * This will help us not lose any data

## Year-to-date facts

* Often requested by business users to get reporting
    * Revenue, profit, cost, etc
    * They are not in the defined grain of the fact table! For example, year to date is not a value for a day!
    * Better to store the value in the defined grain (revenue per day) and then calculate these values in the BI tool
    * If required, optimize with a cube
* Tempted to store them in columns in the data warehouse

## Types of fact tables

### Transactional fact tables

* 1 row => measurement of 1 event / transaction
* Takes place at a specific time (and place usually)
   * A sale
* One transaction defines the grain of the fact table
* Most common and very flexible - can be analyzed at different levels, typically additive
* They tend to have many foreign keys associated with them
* They can be enormous in size, with rapid growth

### Periodic Snapshot fact tables

* 1 row => summarizes measures of many events / transactions
* Summarized of standard period (day, week, month)
* Lowest period defines the grain of the table
* They are not as big in size because of the periouds they emcompass and aggregate, it grows continuously
* Typically they are additive fact tables,
* They have a lot of facts, and not so many dimensions associated with them
* Sometimes we use null or 0 when there are no events to aggregate
    * for example, 0 sales in the weekend, or null sales in the weekend

### Accumulating fact tables

* 1 row => summarizes measures of many events / transactions
* summarized by lifespan of a process (order fullfillment)
* Definite beginning and ending (and steps in between)
* We can have many dates for each of the steps of a process
    * production start, production end, inspection, shipping, delivery
* Has some measures, but many date dimensions
* It's the least common type of fact table
* Good for workflow or process analysis

### Summary of Fact Tables

| Characteristic | Transactional | Periodic Snapshot | Accumulating |
|---------------|---------------|-------------------|--------------|
| Grain | Single event/transaction | Time period summary | Process lifecycle |
| Timing | Single point in time | Regular intervals | Multiple timestamps |
| Size | Very large | Medium | Small to medium |
| Growth rate | Rapid | Steady | Moderate |
| Common use case | Sales transactions | Monthly reports | Order fulfillment |
| Dimensions | Many | Few | Many (dates) |
| Additive | Usually | Typically | Varies |
| Update frequency | Insert only | Regular updates | Multiple updates |

### Special: Factless Fact Table

* Sometimes only the dimensional aspects of a fact are recorded
* Example: table of new employees registered
    * just IDs associated with the dimensions of an employee
    * we count number of rows filtered by date range to get "onboarded employees last month"
* It still allows for analysis


### Fact table design

The 4 key decisions are based on questions and answers to business needs:
* What is the business process that is being analyzed?
    * Sales, order processing, etc
* What is the grain (level of detail) of our table?
    * What is one row referring to?
    * Better to go with a higher level of detail, leaving us open for more aspects of analysis (don't pre-aggregate)
* What are the dimensions that are relevant?
    * What, when, where, how, why
    * Time, location, product, customers, etc etc
    * This is for filtering and grouping (the soul of our data warehouse)
* What are the facts for our measurements?

The highest analytical value comes from the atomic grain. Undivisible data.
Also from the highest dimensionality.


### Natural vs surrogate keys

* A natural key is the key that comes from the source system of data
* A surrogate key is a unique identifier that is generated by the data warehouse itself - created during the ETL process
    * We can use the `_PK` or `_FK` suffix to identify them
    * Normally a integer

Surrogate key benefits:
* Better performance (less storage, better joins)
* We can use them to handle dummy values, like -1 or 999 if there are no values available
* Allows us to better manage and integrate multiple source systems
* Easier to administrate / update values (useful in slowly changing dimensions)
* Sometimes there is no ID available, so we should generate that key

**Just always use surrogate keys**, except for the date dimension, you can use `yyyymmdd` for that.
And keep the natural keys around.

# Dimensions in depth

* Always has a primary key and a surrogate key
    * We can use a lookup table to join the surrogate key into the fact table
* Few rows, but many columns with descriptive attributes
* They help us slice and dice the data

## Date dimension

* One of the most common and important dimensions
    * We want to measure the performance over time
* Contains all the date related features
    * Year, month, day, week, quarter, etc
* Meaningful surrogate key - `YYYYMMDD` or similar depending on the grain
* Normally an extra row for `no date / null` dimension => `1900-01-01` a dummy value

If the time aspect is also important, this should be a separate dimension.

The date/time dimension can be populated in advance for 5 or 10 years in the future.

Date features:

* Both numbers and text
* Long and abbreviated names, depending on the use case / business context
* Combinations of attributes (2022-Q1, 2022-Q2, etc.)
* Fiscal dates
* Flags like `is_weekend`, `is_holiday`, `is_leap_year`, etc.

Example:

| DateKey | CalendarDate | Year | Month | MonthName | Quarter | FiscalYear | IsWeekend | IsHoliday |
|---------|--------------|------|-------|-----------|---------|------------|-----------|-----------|
| 20220101| 2022-01-01   | 2022 | 1     | January   | Q1      | FY2022     | True      | True      |
| 20220102| 2022-01-02   | 2022 | 1     | January   | Q1      | FY2022     | True      | False     |
| 20220103| 2022-01-03   | 2022 | 1     | January   | Q1      | FY2022     | False     | False     |

## Nulls

* Nulls must be avoided in Foreign Keys - replace with dummy value
    * Keep referencial integrity - make sure `nulls` don't disappear
* Nulls can be present in facts (don't forget, read previous chapter)
* Replace nulls in dimensions with their descriptive values, it's best for business users when it's descriptive
    * e.g. `null` -> `No Promo` for example
    * The value will then appear in the BI tool

## Hierarchies

* In source data, the data is often normalized
* If we normalize all the data in the warehouse we end up with a snowflake schema - less practical
    * We should avoid doing this! Less performance and lower usability
* It's better to flatten the data
    * We can have precalculated columns with combinations of attributes (e.g. city-state, state-country)

## Conformed Dimensions

* Used for multiple fact tables or multiple stars
* Used to compare facts acrossed a dimension. For example, the sales and costs facts are connected via the date dimension - it's called a `drill across`.
    * We could use also `region_dimension` or `product_dimension` for example
* We need to have identical attributes or at least a subset of attributes for both facts
* We **do not need** the same granularity for both facts

## Degenerate Dimensions

* A dimension that is not really a dimension
* All the relevant attributes of the dimension have already been extracted into other dimensions
    * We are left only with the primary key - it might still be important to keep, even without other attributes
    * The attribute might be useful for some business users
* We keep the Foreign Key in the fact table, and we can use the suffix `_DD` to indicate that it's a degenerate dimension
    * `_DD` is suggested by Kimball
* Summarizing: It's a dimension key without an associated dimension
    * E.g. invoice number, billing number, order ID


## Junk Dimensions

* We could eliminate this data if not relevant... But some business users might want them
    * We could leave them in the fact table, if we don't want to create a separate dimension table
* But if they are too big or too many, we should separate them
    * It's best not to create 1 dimension per attribute, so we can aggregate them
    * This is how we end up with a junk dimension
* Flags or indicators with low cardinality (low number of different values)
* We don't want to create different storage locations

We can create a dimension with all the possible combinations of these attributes and create a primary key.
Then we can use the foreign key in the fact table. We need to be careful with the number of combinations!

If there are many combinations, extract only the combinations that occur in the fact table.

**Note**: Junk dimension is called "Transactional indicator dimension" for business users. (biz speak)

## Role-playing Dimensions

* A dimension that is referenced in a fact table multiple times
    * for example, a date dimension is used multiple times for different purposes
* We can create SQL Views for a role playing dimension so that we don't duplicate data

## Slowly changing dimensions (SCD)

They are a big imporant concept in data warehousing. Of course the dimensions change, even if they don't change
as much as facts change. Dimensions change in the real world, so we need to have a strategy in place.

1. Be proactive - ask about potential changes
1. Aks business users + developers
1. Create the strategy for the changing attributes
    1. There are different types of slowly changing dimensions
        1. Type 0: Retain Origninal - No changes in dimension, like date, "original product name"
        1. Type 1: Overwrite - only current state is reflected, history is lost
            * Important to take into consideration that some changes might be significant
            * e.g. Product name is less significant than category
            * Changes might also break SQL queries like `case when` statements
        1. Type 2: Add new row
        1. Type 3: Additional Attributes

### Type 2: Add new row

* The most powerful SCD
* It perfectly partitions history of the data
* When there is a change we add an additional row, and the new fact tables should
use the new Foreign Key
* To aggregate correctly the products under multiple categories we can use the `natural key`
* We can also introduce the `effective_from` and `effective_to` columns to track the validity period of each record
    * This lets us track accurately the changing value of the dimension
    * Don't use null for `effective_to` use a date that is very far in the future
    * There will be more details about this in the ETL process
    * This approach mandates the use of the `surrogate key`

Steps:
1. Add row to dimension first
1. Lookup in the dimension with natural key and the effective dates (we find the correct FK)
    1. We can use an `active_flag` to make it easier to find the current version
1. We use the FK in the fact table


Example for category dimension table:

| category_id | natural_key | category_name | active_flag | valid_from  | valid_to    |
|------------|-------------|---------------|-------------|-------------|-------------|
| 1          | C1          | Electronics   | N           | 2020-01-01  | 2021-12-31  |
| 2          | C1          | Technology    | Y           | 2022-01-01  | 9999-12-31  |
| 3          | C2          | Clothes      | Y           | 2020-01-01  | 9999-12-31  |

* The category_id is the surrogate key
* Natural_key helps us identify which rows belong to the same category
* Valid_from and valid_to help us identify when the change happened
* Active_flag helps us identify the current version
* 9999-12-31 represents that the row is still valid

### Mixing type 1 and type 2 SCDs

* We can mix type 1 and type 2 depending on the attribute we are looking at
* The rules need to be defined with the business users! It's not up to the data modeler
    * They need to know if they want to keep track of the history

## Type 3: Additional Attributes

* It's an in-between approach: switches back and forth between type 1 and type 2
* Instead of adding a row, we add an additional column which contains the previous value
* Typically used for significant changes at a time
    * Restructuring in organizations, e.g. different regions
* We can switch between historic / current view
* New attributes => New rows, and the previous columns can be `Not applicable`
* It is possible to add multiple historic columns

There are some limitations:
* Not suitable for frequent or unpredictavle changes => Type 2
* Not suitable for changes that are not significant => Type 1

This is the **least frequently** used SCD.


# The ETL Process

## Extract

_A deeper dive into the E._

We bring the data from the source systems into the staging layer of the Data Warehouse.
Don't forget the staging layer is of a transient type - deleted after the data is processed.

In the staging area we:
* Understand the data
* Transform the data

There are 2 types of loads:
* Initial Load - the first real run
* Delta Load - incremental load, the subsequent runs

The Initial Load:
1. Extract all of the data from the source systems
    1. After discussions with the business users and the IT teams
    1. What data is needed, how it's structured, how it's stored
    1. When is a good time to extract this data - initial load is the largest load
    1. We can do smaller extracts to test how the process behaves
1. Copy all of the data into the staging area
1. Apply all of the transformations and load the data to the Core layer
    1. All the data from staging gets copied, no time filtering (that's for Delta Loads)

The Delta Load:
1. Decide what the periodic extraction looks like / frequency when to load
    1. We require a delta column for every table (timestamps)
    1. `transaction_date`, `create_date`, `create_at`, etc
    1. We can also use a Primary Key, but we require them to have incremental values
1. We have to remember the `MAX(sales_key)` into a variable (or max timestamp...)
    1. Then we only load data that is bigger than the variable

There are some tools that automatically handle which data to extract, via the metadata.
If you have that tool, use it. Otherwise you need to implement this solution.

It is important to understand data volumes so that performance can be monitored and optimized.
Don't forget that the more data we load, the longer it takes to process.

## Load

We use Insert/Update to load data into the Core layer. It depends on the case for each table.

The common type is Insert/Append - we append data that did not exist before. Sometimes we need to update existing data, we do that based on the Primary Key we use. These are the main operations we use in the Load process.

Normally we do not *delete* any data. We want to keep the history of our data.

What happens if a Dimension gets deleted in a source system? We don't delete from the data warehouse. We can mark it as deleted by setting a flag or updating a status column.


## Transform

Goals:

1. Consolidate the data (from multiple data systems)
1. Clean and Reshape the data (for analytical purposes)
    1. Deduplication
    1. Filtering (rows and columns)
    1. Cleaning and mapping
        * Consider null values
    1. Value Standardization
        * Consider the units of values
    1. Key generation

We can also have more advanced cleaning:

* Joining
* Splitting
* Aggregating
* Deriving new values

Guidelines:

* What are the requirements?
    * per day?
* How long does it take?
    * 5min extraction?
* What is a good time to it?
    * effect on product_dimension
    * short read Access
    * night or morning?

ETL
* Enterprise
    * commercial
    * mature
    * GUI
    * Architectural needs
    * Support
* Open Source
    * Public source code
    * Often free
    * Support? sometimes
    * Ease of use?
* Cloud
    * Cloud technology
    * Data already in cloud?
    * Efficiency?
    * Flexibility?
* Custom
    * Own development
    * Customized
    * Heavy on resources
    * Low on maturity
    * Maintenance
    * Training

Choosing an ETL Tool:

Cost, Connectors, Capabilities, Ease of use / work, Reviews, Support / Extras

ETL vs ELT:

ETL is not obsolete, they have different use cases.

ETL:
* More stable with defined transformations
* More generic use-cases, when we know what the data should look like
* Security can be handled better, only use the information that is less sensitive in the data warehouse

Use-cases: Reporting (not real time), generic use cases, easy to use,

ELT:
* Requires high performance DB
* More flexible
* Transformations can be changed quickly
* Easier to work real-time, the process from extracting and loading is a lot faster

Use-cases: Data Science, ML, real-time analytics, Big Data (high volume)

# Using your data warehouse

* Basis for reporting for strategic decisions
* Business users can analyze the Data
* Predictive analytics
* Use Big Data

# Database indexes

## B-tree indexes

* multi level tree structure, breaks data into pages or blocks
* Should be used for high cardinality (unique) columns
    * Remember, cardinality means the number of distinct values in a column

## Bitmap indexes

* Particularly good for large amounts of data with low cardinality
    * 3 different values, but many rows
* Very efficient Storage
* Great for read performance, and few DML operations
    * DML operations means data manipulation language operations, such as INSERT, UPDATE, and DELETE.

## Guidelines

* Use to avoid full table scans on large Tables, when there is low query performance
* Use when we want to use columns as filters

* B-tree
    * unique columns, surrogate keys, names
* Bitmap
    * Storage efficient
    * Great read performance
