# DynamoDB Migrations

**Goal**: Implement iterative enhancements to the DynamoDB data model.

## Required Reading

- [OneTable CLI for DynamoDB Migration](https://www.sensedeep.com/blog/posts/2021/onetable-cli.html)

## Online Shop

![Overview](./diagrams/030-dynamodb-migrations.drawio.svg "Overview")

### Introducing the Supplier Entity
Incorporate a new entity named 'Supplier' into your DynamoDB table and seed the related mock data. 

### API Integration with Supplier Entity
Construct new APIs facilitating the following actions:
- Retrieve all suppliers.
- Fetch a specific supplier based on its ID.
- List all products associated with a specific supplier, using its ID. 
- For optimizing this retrieval process, add a new GSI to avoid table scans.

### Implementing the GSI in CDK
Integrate the new Global Secondary Index (GSI) using CDK. This integration will cater to the current products. To ensure consistency and correctness, set up a migration mechanism to populate the GSI for the already existing products.

### Testing

Invoke the new APIs to ensure that they work consistently.

## Further Resources

- [Migrating Data Structures in DynamoDB](https://spin.atomicobject.com/2020/10/20/dynamodb-migrate-data-structures/)
- [DynamoDB OneTable Migration Library](https://github.com/sensedeep/onetable-migrate/blob/main/README.md)
- [Best Practices for Secondary Indexes with DynamoDB](https://www.trek10.com/blog/best-practices-for-secondary-indexes-with-dynamodb) 
