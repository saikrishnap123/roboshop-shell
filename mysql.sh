echo -e "\e[33mDisabling mysql default version \e[0m"
yum module disable mysql -y &>>/tmp/roboshop.log 

echo -e "\e[33mEnable redis version 6 \e[0m"
cp /home/centos/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>>/tmp/roboshop.log

echo -e "\e[33mInstall mysql community server \e[0m"
yum install mysql-community-server -y &>>/tmp/roboshop.log

echo -e "\e[33mStart mysql server  \e[0m"
systemctl enable mysqld &>>/tmp/roboshop.log
systemctl start mysqld  &>>/tmp/roboshop.log

echo -e "\e[33mSetup mysql password \e[0m"
mysql_secure_installation --set-root-pass RoboShop@1 &>>/tmp/roboshop.log

