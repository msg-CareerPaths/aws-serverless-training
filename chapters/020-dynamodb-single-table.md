# DynamoDB Single Table Design

**Goal**: Transition to data persistence using DynamoDB.

## Required Reading

- [Getting started with DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GettingStartedDynamoDB.html)
- [The What, Why, and When of Single-Table Design with DynamoDB](https://www.alexdebrie.com/posts/dynamodb-single-table/)
- [SenseDeep DynamoDB OneTable - Quick Tour](https://doc.onetable.io/start/quick-tour/)

## Online Shop

![Overview](https://raw.githubusercontent.com/msg-CareerPaths/aws-serverless-training/master/chapters/diagrams/020-dynamodb-single-table.drawio.svg "Overview")

### Setting up the DynamoDB Table
Set up a new DynamoDB table for the shop. Use the "On Demand" capacity model.

### Designing the Single-Table Schema
Adhere to the following guidelines for constructing a single-table schema for products and categories:
- Incorporate both a Partition and a Sort key, denoting them technically as PK and SK respectively.
- Given the limited number of categories (under two hundred), maintain a static/constant partition key for them (e.g., PK = "CATEGORIES"). Assign the category ID as part of the sort key (e.g., SK = "CATEGORY#123").
- As products will be more numerous (upwards of tens of thousands), employ a dynamic partition key containing the product ID (e.g., PK = "PRODUCT#ABC"). The sort key can be kept static/constant or identical to the partition key (e.g., SK = "PRODUCT#ABC").
- Add support for reading products by category using a Global Secondary Index. Give technical names to the partition and sort keys of this index (i.e., GSI1PK, GSI1SK), to ensure it can be "overloaded" in the future (see [this post](https://www.trek10.com/blog/best-practices-for-secondary-indexes-with-dynamodb#:~:text=a%20secondary%20index.-,Overloading%20your%20secondary%20indexes,-A%20second%20way) for an explanation). To support reading products by category, the partition key of the index must be dynamic and contain the category ID (e.g., GSI1PK = "CATEGORY#123"), and the sort key of the index must be dynamic and contain the product ID (e.g., GSI1SK = "PRODUCT#ABC").

### Lambda Integration with DynamoDB
Modify the Lambdas by doing the following:
- Grant the necessary permissions to interact with the table.
- Pass the table name from CDK to Lambda using environment variables.
- Change the repositories to work with `dynamodb-onetable`.

### Data Seeding Script
Develop an executable local script under a new `scripts` folder. This script should populate the DynamoDB table by sourcing mock data from the `data` directory of this repository.

### Testing

Invoke each of your APIs to ensure that they work consistently.

## Further Resources

- [Creating a single-table design with Amazon DynamoDB](https://aws.amazon.com/blogs/compute/creating-a-single-table-design-with-amazon-dynamodb/)
- [DynamoDB OneTable API Overview](https://www.sensedeep.com/blog/posts/2021/dynamodb-onetable-tour.html)
- [Data Modeling for DynamoDB Single Table Design](https://www.sensedeep.com/blog/posts/2021/dynamodb-singletable-design.html)
- [DynamoDB with OneTable Schemas](https://www.sensedeep.com/blog/posts/2021/dynamodb-schemas.html)
- [Choosing the Right DynamoDB Partition Key](https://aws.amazon.com/blogs/database/choosing-the-right-dynamodb-partition-key/)
- [Using Global Secondary Indexes in DynamoDB](https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GSI.html)
- [How to model one-to-many relationships in DynamoDB](https://www.alexdebrie.com/posts/dynamodb-one-to-many/#secondary-index--the-query-api-action)
