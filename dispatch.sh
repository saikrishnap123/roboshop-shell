echo -e "\e[33mInstall golang  \e[0m"
yum install golang -y &>>/tmp/roboshop.log

echo -e "\e[33mAdd user  \e[0m"
useradd roboshop &>>/tmp/roboshop.log

echo -e "\e[33mCreate directory  \e[0m"
rm -rf /app &>>/tmp/roboshop.log
mkdir /app 

echo -e "\e[33mInstall dispatch content  \e[0m"
curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch.zip &>>/tmp/roboshop.log
cd /app 

echo -e "\e[33mExtract the content   \e[0m"
unzip /tmp/dispatch.zip &>>/tmp/roboshop.log

echo -e "\e[33mSetup systemd file  \e[0m"
cp /home/centos/roboshop-shell/dispatch.service /etc/systemd/system/dispatch.service &>>/tmp/roboshop.log

echo -e "\e[33mdownload the dependencies & build the software.  \e[0m"
cd /app &>>/tmp/roboshop.log
go mod init dispatch &>>/tmp/roboshop.log
go get &>>/tmp/roboshop.log
go build &>>/tmp/roboshop.log

echo -e "\e[33mStart service \e[0m"
systemctl daemon-reload &>>/tmp/roboshop.log
systemctl enable dispatch &>>/tmp/roboshop.log
systemctl start dispatch &>>/tmp/roboshop.log