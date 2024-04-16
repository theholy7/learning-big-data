

## Mac OS
The easiest way to experiment with PySpark is to use a Jupyter Notebook running on a Docker container with PySpark already set up.

### Instructions
1. Open the [Docker Desktop application](https://docs.docker.com/desktop/install/mac-install/)
2. Open the terminal and run `docker run -p 8888:8888 jupyter/pyspark-notebook`
3. In the logs of your terminal, you should see the local host + port and your access token. For example: `http://127.0.0.1:8888/lab?token=3bf04c85c527d269598a95d7ef1a429bc4069d251f7170ed`. Open your browser and past the link.
4. Open a Notebook Python 3 console
5. Create a Spark Context:

```python
import pyspark
sc = pyspark.SparkContext('local[*]')
```

A Spark Context is the object that allows you to connect to a Spark cluster.
In this case, we are using `local[*]` because we are using a local cluster (i.e. only our local machine).
The `*` tells Spark to create as many workers as the logical cores of your machine.

The logical cores are the number of physical cores * the number of threads that can be run on every core.
For example, if you have a 4-core processor that runs 2 threads per core, you will get 8 logical cores.


### Simple Example
Say we want to create a simple RDD (Resilient Distributed Dataset):

```python
big_list = range(1000)
rdd = big_list.parallelize(big_list, 2)

# print out the first 5 elements
# [0, 1, 2, 3, 4]
rdd.take(5)
```

and then we want to create another RDD only with the odd values

```python
odds = rdd.filter(lambda x: x % 2 != 0)

# print out the first 5 odd elements
# [1, 3, 5, 7, 9]
odds.take(5)
```
