# AWS Shell Scripting Project

This project is designed to automate the process of listing AWS resources and sending reports via email using a shell script. It is particularly useful for companies aiming for cost optimization by regularly monitoring their AWS resources. Additionally, a cron job is added to automate the script execution daily at midnight.

## Features

    - Lists AWS resources (e.g., EC2 instances, S3 buckets, etc.)
    - Sends resource reports via email using Gmail
    - Automates daily execution with a cron job

## Prerequisites

    - AWS EC2 instance
    - AWS CLI installed and configured
    - SMTP client (msmtp) installed for sending emails


### Step 1: Check AWS Resources List

#### 1. Write the Shell Script
Create a shell script named aws_resource_list.sh that will list AWS resources.

#### 2. Create an AWS EC2 Instance

#### 3. Connect to Your EC2 Instance
Use SSH to connect to your EC2 instance:
```bash
ssh -i "key-pair-name.pem" ubuntu@your-public-ip-address
```

#### 4. Install AWS CLI
Update your instance and install the AWS CLI:
```bash
sudo apt update
sudo apt install unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

```

#### 5. Verify AWS CLI Installation
Check if AWS CLI is installed correctly:
```bash
aws --version
```

#### 6. Configure AWS CLI Settings 
- Go to security credentials 
- Find the section "Access Key"
- Then click "Create access key"
- Then get your Access Key and Secret access key and copy that

#### 7. Configure AWS CLI
Configure the AWS CLI with your credentials:
```bash
aws configure
```
- Follow the prompts to enter your Access Key, Secret Access Key, default region name, and output format (JSON).

#### 8. Create the Shell Script File
Create a new shell script file:
```bash
touch aws_resource_list.sh
```

#### 9. Edit and Write the Script
Edit the script file and add your script content:
```bash
vim aws_resource_list.sh
```
- Press i to insert text.
- Paste the shell script.
- Press esc and then :wq to save and exit.

#### 10. Make the Script Executable
Grant execution permissions to the script:
```bash
chmod +x aws_resource_list.sh
```

#### 11. Run the Script
Execute the script to check AWS resources:
```bash
./aws_resource_list.sh us-east-1 ec2
```
- This command lists the EC2 instances running in the us-east-1 region.


### Step 2: Add a Cron Job

#### 12. Edit the Crontab File
Open the crontab file to schedule the script:
```bash
crontab -e
```

#### 13. Schedule the Script to Run Daily at Midnight
Add the following line to the crontab file:
```bash
0 0 * * * /home/ubuntu/aws_resource_list.sh us-east-1 ec2
```
- This will run the script every day at midnight.


### Step 3: Upgrade Project to Send Emails Using Gmail

#### 14. Install the SMTP Client
Install the necessary packages for sending emails:
```bash
sudo apt update
sudo apt install msmtp mailutils
```

#### 15. Configure msmtp for Gmail

##### 15.1 Generate an App Password for Gmail
1. Enable Two-Factor Authentication (2FA) on your Google account.
2. Generate an App Password:
    - In the Security section, find "App passwords."
    - Create an app password and copy the 16-character code.
##### 15.2 Create the msmtp Configuration File
Create and edit the ~/.msmtprc file:
```bash
vim ~/.msmtprc
```
##### 15.3 Add the Following Configuration command(get it from github repo)
Replace your_email@gmail.com with your Gmail address and your_app_password with the app password you generated
##### 15.4 Save and exit 
enter ese and :wq

#### 16. Secure the Configuration File
Protect your credentials by restricting access to the configuration file:
```bash
chmod 600 ~/.msmtprc
```

#### 17. Modify the Shell Script to Send Emails
Update your shell script to include the email-sending functionality. The modified script is available in the GitHub repository.

#### 18. Make Sure the Script is Executable
Ensure the script has execution permissions:
```bash
chmod +x /home/ubuntu/aws_resource_list.sh
```

#### 19. Manually Run the Script
Test the script by running it manually:
```bash
./aws_resource_list.sh us-east-1 ec2
```

#### 20. Check Your Gmail Inbox
You should receive an email titled "AWS Resource Report - EC2 in us-east-1" containing the list of EC2 instances.


## Conclusion
This project automates AWS resource monitoring and reporting, providing a practical solution for companies to keep track of their cloud infrastructure. By following the steps outlined in this guide, you can easily replicate this setup and extend it to monitor other AWS services.


