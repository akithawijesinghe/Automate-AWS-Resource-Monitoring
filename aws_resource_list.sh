#!/bin/bash

##############################################################################
# This script will list all the resources in the aws account
# Author : Akitha/Devops Team
# Version : v0.0.2
#
# Following Supported AWS Services by the script
# 1. EC2
# 2. RDS
# 3. S3
# 4. CloudFront
# 5. VPC
# 6. IAM
# 7. Route53
# 8. CloudWatch
# 9. CloudFormation
# 10. Lambda
# 11. SNS
# 12. SQS
# 13. DynamoDB
# 14. VPC
# 15. EBS
#
# Usage : ./aws_resource_list.sh <region> <service_name>
# Example : ./aws_resource_list.sh us-east-1 EC2
##############################################################################

#check the required num of argument passed
if [ $# -ne 2 ]; then
    echo "Usage: ./aws_resource_list.sh  <aws_region> <aws_service>"
    echo "Example: ./aws_resource_list.sh us-east-1 ec2"
    exit 1
fi

# Assign the arguments to variables and convert the service to lowercase
aws_region=$1
aws_service=$(echo "$2" | tr '[:upper:]' '[:lower:]')

# Check if the AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install the AWS CLI and try again."
    exit 1
fi

# Check if the AWS CLI is configured
if [ ! -d ~/.aws ]; then
    echo "AWS CLI is not configured. Please configure the AWS CLI and try again."
    exit 1
fi

# Initialize a variable to store the output
output=""

# Add timestamp
output+="AWS Resource Report - $(date)\n\n"

# List the resources based on the service
case $aws_service in
    ec2)
        output+="Listing EC2 Instances in $aws_region\n"
        output+=$(aws ec2 describe-instances --region "$aws_region")
        ;;
    rds)
        output+="Listing RDS Instances in $aws_region\n"
        output+=$(aws rds describe-db-instances --region "$aws_region")
        ;;
    s3)
        output+="Listing S3 Buckets\n"
        output+=$(aws s3api list-buckets --query "Buckets[].Name" --output text)
        ;;
    cloudfront)
        output+="Listing CloudFront Distributions\n"
        output+=$(aws cloudfront list-distributions --query "DistributionList.Items[].Id" --output text)
        ;;
    vpc)
        output+="Listing VPCs in $aws_region\n"
        output+=$(aws ec2 describe-vpcs --region "$aws_region")
        ;;
    iam)
        output+="Listing IAM Users\n"
        output+=$(aws iam list-users --query "Users[].UserName" --output text)
        ;;
    route53)
        output+="Listing Route53 Hosted Zones\n"
        output+=$(aws route53 list-hosted-zones --query "HostedZones[].Name" --output text)
        ;;
    cloudwatch)
        output+="Listing CloudWatch Alarms in $aws_region\n"
        output+=$(aws cloudwatch describe-alarms --region "$aws_region")
        ;;
    cloudformation)
        output+="Listing CloudFormation Stacks in $aws_region\n"
        output+=$(aws cloudformation describe-stacks --region "$aws_region")
        ;;
    lambda)
        output+="Listing Lambda Functions in $aws_region\n"
        output+=$(aws lambda list-functions --region "$aws_region" --query "Functions[].FunctionName" --output text)
        ;;
    sns)
        output+="Listing SNS Topics in $aws_region\n"
        output+=$(aws sns list-topics --query "Topics[].TopicArn" --output text)
        ;;
    sqs)
        output+="Listing SQS Queues in $aws_region\n"
        output+=$(aws sqs list-queues --region "$aws_region" --query "QueueUrls" --output text)
        ;;
    dynamodb)
        output+="Listing DynamoDB Tables in $aws_region\n"
        output+=$(aws dynamodb list-tables --region "$aws_region" --query "TableNames" --output text)
        ;;
    ebs)
        output+="Listing EBS Volumes in $aws_region\n"
        output+=$(aws ec2 describe-volumes --region "$aws_region")
        ;;
    *)
        echo "Invalid service. Please enter a valid service."
        exit 1
        ;;
esac

# Define the recipient email
recipient="your-email@gmail.com"

# Define the email subject
subject="AWS Resource Report - $aws_service in $aws_region"

# Send the email
echo -e "Subject: $subject\n\n$output" | msmtp "$recipient"

# Optionally, log the output to a file
echo -e "$output" >> /home/ubuntu/log_file.log 2>&1
