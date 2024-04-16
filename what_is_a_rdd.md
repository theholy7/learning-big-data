# What is a RDD?

A RDD (Resilient Distributed Dataset) is the main abstraction we can find in Spark.
It is a collection of elements partitioned across the nodes of the cluster.
On these elements, Spark is able to operate in parallel.

You can also persist RDD in memory, in order to re-use them efficiently across operations.


### References
- [RDD Programming Guide](https://spark.apache.org/docs/latest/rdd-programming-guide.html)