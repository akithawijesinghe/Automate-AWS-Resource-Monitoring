#This file is msmtprc 
#in your shell enter this coomand and add below configurations
#vim ~/.msmtprc
-----------------------------------------------------------------------------


# Set default values for all following accounts.
defaults
auth           on
tls            on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
logfile        ~/.msmtp.log

# Gmail account configuration
account        gmail
host           smtp.gmail.com
port           587
from           your_email@gmail.com
user           your_email@gmail.com
password       your_app_password

# Set a default account
account default : gmail
