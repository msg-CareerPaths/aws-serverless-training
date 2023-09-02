# EventBridge Rules, S3 Storage, and SNS Topics

**Goal:** Design a mechanism to produce daily reports of orders, store these reports in an Amazon S3 bucket, and notify the store owner using Amazon SNS.

## Required Reading

- [Creating an Amazon EventBridge rule that runs on a schedule](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-create-rule-schedule.html)
- [What is Amazon S3?](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html)
- [How to use puppeteer with AWS Lambda](https://www.cloudtechsimplified.com/puppeteer-aws-lambda/)
- [Tutorial: Using an Amazon S3 trigger to invoke a Lambda function](https://docs.aws.amazon.com/lambda/latest/dg/with-s3-example.html)
- [Sharing objects with presigned URLs](https://docs.aws.amazon.com/AmazonS3/latest/userguide/ShareObjectPreSignedURL.html)
- [Sending Email Notifications with Amazon SNS](https://mailtrap.io/blog/amazon-sns-guide/)

## Online Shop

![Overview](./diagrams/060-eb-s3-sns.drawio.svg "Overview")

### DynamoDB Adjustments

- **Migration**: Modify the existing DynamoDB model through a migration process.
- **GSI Overloading**: Enhance a Global Secondary Index (GSI) to facilitate queries for orders placed after a specified date.

### S3 Setup & Report Generation

- **S3 Bucket Creation**: Establish a new S3 bucket dedicated to storing daily order reports.
- **EventBridge Rule**: Formulate a schedule-driven rule using EventBridge to activate a Lambda daily.
- **Lambda Configuration**: The invoked Lambda should:
   - Query the DynamoDB table to retrieve all orders from the previous day.
   - Generate a PDF report, enlisting all products required to fulfill these orders, categorized by: Customer, Address, Product, and Quantity.
   - Use Handlebars to craft an HTML template of the report.
   - Utilize Puppeteer to convert this HTML template into a PDF format.
   - Deposit this PDF report into the S3 bucket, with a naming convention based on the current date/time.

You can find templates for the report and the notification in the `templates` directory of this repository.

### SNS Configuration & Notification

- **SNS Topic Creation**: Develop an SNS topic.
- **Subscription**: Enroll the store owner's (your) email to this topic. Verify its functionality by manually dispatching a test notification.
- **S3 Lambda Trigger**: Configure a Lambda function to get activated upon the uploading of a new PDF report to the S3 bucket. This Lambda's responsibilities include:
   - Constructing a presigned URL pointing towards the new S3 object.
   - Dispatching an SNS notification embedding this presigned URL, ensuring the store owner receives an email containing the report link.

### Testing

1. **Schedule Alteration**: Temporarily modify the EventBridge schedule for more frequent triggers.
2. **Validation**: Ensure that the entire process, encompassing report generation, its storage, and subsequent notification to the store owner, works properly.

## Further Resources

- [Tutorial: Schedule AWS Lambda functions using EventBridge](https://docs.aws.amazon.com/eventbridge/latest/userguide/eb-run-lambda-schedule.html)
- [Node.js — Create a PDF from HTML with Puppeteer and Handlebars](https://futurestud.io/tutorials/node-js-create-a-pdf-from-html-with-puppeteer-and-handlebars)
- [Best Practices for Secondary Indexes with DynamoDB](https://www.trek10.com/blog/best-practices-for-secondary-indexes-with-dynamodb)
- [How to set up an Amazon S3 Bucket using AWS CDK](https://towardsthecloud.com/aws-cdk-s3-bucket)
- [AWS SNS: Getting started](https://docs.aws.amazon.com/sns/latest/dg/sns-getting-started.html)
- [AWS SNS: Email notifications](https://docs.aws.amazon.com/sns/latest/dg/sns-email-notifications.html)
