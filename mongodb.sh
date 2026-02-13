#!/bin/bash

source ./common.sh

check_root

cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "Adding Mongo repo"

dnf install mongodb-org -y &>>$LOG_FILE
VALIDATE $? "Installing Mongodb"

systemctl enable mongod &>>$LOG_FILE
VALIDATE $? "Enabling Mongodb"

systemctl start mongod  &>>$LOG_FILE
VALIDATE $? "Starting Mongodb"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "Allowing remote connections to MongoDB"

systemctl restart mongod &>>$LOG_FILE
VALIDATE $? "restarting Mongodb"

print_total_time