echo -e "\e[33mConfiguring Nodejs repos\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[33mInstalling nodejs\e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33mAdd application User\e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33mcreate application directory\e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app 

echo -e "\e[33mDownload Application content \e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip &>>/tmp/roboshop.log
cd /app 

echo -e "\e[33mExtract Application content\e[0m"
unzip /tmp/catalogue.zip &>>/tmp/roboshop.log
cd /app 

echo -e "\e[33mInstall Nodejs Dependencies\e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[33mSetup systemd service\e[0m"
cp /home/centos/roboshop-shell/catalogue.service /etc/systemd/system/catalogue.service &>>/tmp/roboshop.log

echo -e "\e[33mStart catalogue service\e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable catalogue &>>/tmp/roboshop.log
systemctl start catalogue &>>/tmp/roboshop.log

echo -e "\e[33mCopy mongo repo file \e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[33mInstall mongodb client\e[0m"
yum install mongodb-org-shell -y &>>/tmp/roboshop.log

echo -e "\e[33meLoad Schema \e[0m"
mongo --host mangodb-dev.manikantap139.store </app/schema/catalogue.js &>>/tmp/roboshop.log
