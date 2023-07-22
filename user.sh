echo -e "\e[33mConfiguring nodejs repos \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[33mInstall nodejs \e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33mAdd application user \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33mCreate application directory \e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app 

echo -e "\e[33mDownload application content \e[0m"
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip &>>/tmp/roboshop.log
cd /app 

echo -e "\e[33mExtract Application content \e[0m"
unzip /tmp/user.zip &>>/tmp/roboshop.log
cd /app 

echo -e "\e[33mInstalling nodejs dependencies \e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[33mSetup systemd Service \e[0m"
cp /home/centos/roboshop-shell/user.service /etc/systemd/system/user.service &>>/tmp/roboshop.log

echo -e "\e[33mStart service \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable user &>>/tmp/roboshop.log
systemctl start user &>>/tmp/roboshop.log

echo -e "\e[33mCopy mongodb repo files \e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[33mInstall mongodb client\e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[33mLoad schema \e[0m"
mongo --host mongodb-dev.manikantap139.store </app/schema/user.js &>>/tmp/roboshop.log