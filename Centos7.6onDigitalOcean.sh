SUPPORTPW=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 20 | head -n 1)
yum install -y epel-release yum-utils http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum-config-manager --enable remi-php73

cat > /etc/yum.repos.d/mariadb.10.3.repo << EOF
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.3/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
EOF

yum -y update
yum -y install mariadb mariadb-server vim httpd wget zip unzip mod_ssl openssl php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysqlnd php-xml php-mbstring php-soap percona-toolkit
systemctl start httpd
systemctl enable apache
systemctl start mariadb
systemctl enable mariadb
apachectl restart
cd /var/www/html

wget --quiet https://github.com/aworley/ocm/archive/master.zip
unzip master.zip
yes | rm master.zip
mv ocm-master/cms .
mv ocm-master/cms-custom/ .
rm -rf ocm-master
mysql -uroot -e "create database cms"
cat cms/app/sql/install/new_install.sql | mysql -uroot cms
mysql -uroot -e "update users set username='support', password=md5('${SUPPORTPW}')" cms
echo -e "You can now log into your OCM instance with username support and password of \n\n"${SUPPORTPW}"\n"
echo -e "\nYou should additionally run mysql_secure_installation and set the database connection password in settings.php as currently Pika is configured to authenticate to mariadb with a blank password. Perhaps later I will automate this as part of my script according to the description here https://bertvv.github.io/notes-to-self/2015/11/16/automating-mysql_secure_installation/\n"


