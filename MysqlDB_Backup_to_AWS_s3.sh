#!/bin/bash
DATE=`date +%Y%m%d`
DB_BACKUP="$DATE"_MYSQL_backup.sql

export AWS_ACCESS_KEY_ID=AKIAZOEO5UZMMAKG672Z

USERNAME=$1
DB_PASSWORD=$2
DB_HOST=$3
DB_NAME=$4
AWS_SECRET=$5
BUCKET_NAME=$6
echo "Starting of script.."
echo "Proceeding with mysql db backup.."
mysqldump -u $USERNAME -p$DB_PASSWORD -h $DB_HOST $DB_NAME > /tmp/$DB_BACKUP && \
echo "Backup taken, proceeding with uploading to AWS S3 bucket.." && \
export AWS_SECRET_ACCESS_KEY=$AWS_SECRET && \
aws s3 cp /tmp/$DB_BACKUP s3://$BUCKET_NAME/$DB_BACKUP
echo "Upload complete. Exiting"
