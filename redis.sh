echo -e "\e[33mInstalling redis repo \e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>/tmp/roboshop.log

echo -e "\e[33mEnable redis version 6 \e[0m"
yum module enable redis:remi-6.2 -y &>>/tmp/roboshop.log

echo -e "\e[33mInstalling redis service \e[0m"
yum install redis -y &>>/tmp/roboshop.log

echo -e "\e[33mUpdate redis listen address \e[0m"
sed -i 's/127.0.0.1/0.0.0.0/' /etc/redis.conf /etc/redis/redis.conf &>>/tmp/roboshop.log

echo -e "\e[33mStart redis service \e[0m"
systemctl enable redis &>>/tmp/roboshop.log
systemctl start redis &>>/tmp/roboshop.log