# PikaInstallScripts
Pika/OCM Install Scripts

The scripts in this repository can be used to set up basic Pika development server in an automated fashion. It is not meant to configure a "full" production server with backups, ssl certificates, etc, but would also be a good starting point for that.

Here is an example as to how to run it after logging into an AWS Lightsail LAMP image for the first time:
```
wget https://raw.githubusercontent.com/amsclark/PikaInstallScripts/master/LightSail.sh
sudo -s
bash ./LightSail.sh
```
Here is an example as to how to run it after logging into a Centos 7.6 Digital Ocean Droplet for the first time
```
curl -LJO https://raw.githubusercontent.com/amsclark/PikaInstallScripts/master/Centos7.6onDigitalOcean.sh
bash ./Centos7.6onDigitalOcean.sh
```
