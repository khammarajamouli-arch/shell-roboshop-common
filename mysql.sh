#!/bin/bash

source ./common.sh

check_root

dnf install mysql-server -y &>>$LOG_FILE
VALIDATE $?  "installing mysql server"

systemctl enable mysqld &>>$LOG_FILE
VALIDATE $? "enabling mysqld"

systemctl start mysqld  &>>$LOG_FILE
VALIDATE $? "starting the mysqld"

mysql_secure_installation --set-root-pass RoboShop@1

print_total_time