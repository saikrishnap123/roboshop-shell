echo -e "\e[33mCopy mongodb repo file \e[0m"
cp /home/centos/roboshop-shell/mongo.repo /etc/yum.repos.d/mongo.repo &>>/tmp/roboshop.log

echo -e "\e[33mInstalling mongodb server \e[0m"
yum install mongodb-org -y &>>/tmp/roboshop.log

echo -e "\e[33mUpdate mongodb listner port \e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf 

echo -e "\e[33mStart mongodb service \e[0m"
systemctl enable mongod &>>/tmp/roboshop.log
systemctl restart mongod &>>/tmp/roboshop.log

