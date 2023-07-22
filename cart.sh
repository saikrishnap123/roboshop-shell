echo -e "\e[33mConfiguring nodejs repos \e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>/tmp/roboshop.log

echo -e "\e[33mInstalling Nodejs \e[0m"
yum install nodejs -y &>>/tmp/roboshop.log

echo -e "\e[33mAdd application user \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33mCrearte application directory \e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app 

echo -e "\e[33mDownload application content \e[0m"
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart.zip &>>/tmp/roboshop.log
cd /app 

echo -e "\e[33Extract apllication content \e[0m"
unzip /tmp/cart.zip &>>/tmp/roboshop.log
cd /app 

echo -e "\e[33mInstalling nodejs dependencies \e[0m"
npm install &>>/tmp/roboshop.log

echo -e "\e[33mSetup systemd Service \e[0m"
cp /home/centos/roboshop-shell/cart.service /etc/systemd/system/cart.service &>>/tmp/roboshop.log

echo -e "\e[33mInstalling \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable cart &>>/tmp/roboshop.log
systemctl start cart &>>/tmp/roboshop.log