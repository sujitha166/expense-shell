#!/bin/bash

Logs_Folder="/var/log/Expense-shell"
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
TIMESTAMO=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME-$TIMESTAMP.log"
mkdir -p $Logs_Folder

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
N="\e[0m"
y="\e[33m"


CHECK ROOT(){
if [ $USERID -ne 0 ]
then
   echo -e "$R please run this script with root privilages $N" | tee -a $LOG_FILE
   exit 1
fi
}

VALIDATE(){
    if [ $1 -ne 0 ]
    then
     echo -e "$2 is...$R FAILED $N" tee -a $LOG_FILE
     exit 1
     else 
     echo -e "$2 is... $G SUCCESS $N" tee -a $LOG_FILE

}


echo "script started excecuting at: $(Date)" tee -a $LOG_FILE



CHECK_ROOT

dnf install mysql-server -y
VALIDATE = $? "Installing mysqlserver"

systemctl enable mysqld
VALIDATE = $? "enabled mysql server"

systemctl start mysqld
VALIDATE = $? "started mysql server"

mysql_secure_installation --set-root-pass ExpenseApp@1
VALIDATE = "setting up root password"