#Disclaimer, this is obviously for linux based systems although I may port it to windows.
#In the meantime you can set up a vmware image to run on your host machine with relative ease, I prefer ubuntu for the specfic project.

#Mail can't be sent out via port 25 for comcast, need to pivot off of googles at smtp.gmail.com port 587

#Make sure you have the following packages;
Apt-get install sharutils
Apt-get install dnsutils
Apt-get install mailutils

#Create a file and put the following into it. (vi example.sh)
#!/bin/bash
myip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
date="$(date '+%A %x %X')"
echo "My WAN/Public IP address on ${date} is: ${myip}" > /MailDump.d
echo "My WAN/Public IP address on ${date} is: ${myip}" >> /MailDump.w

#Dont forget to chmod the file, chmod 777 example.sh

#Add gmails smtp server to your pivot point

vi /etc/ssmtp/revaliases

#Add the following at the bottom of the file
root:tipsmobilebranch@gmail.com:smtp.gmail.com:587

#Add your own credentials to /etc/ssmtp/ssmtp.conf, it should look something like this;
root=MyEmailAddress@gmail.com
mailhub=smtp.gmail.com:587
AuthUser=MyEmailAddress@gmail.com
AuthPass=MyPassword
UseTLS=YES
UseSTARTTLS=YES
rewriteDomain=gmail.com
hostname=MyEmailAddress@gmail.com
FromLineOverride=YES

#Finally run this command to send a test message REPLACE THE EXAMPLE TEXT AND PATHS TO THE FILES WITH YOUR OWN OBVIOUSLY
echo -e "to: EXAMPLE.COM\nsubject: EXAMPLE\n"| (cat - && uuencode /MailDump.w MailDump.text) | ssmtp EXAMPLE@gmail.com

#Now just add the bash scripts you created above to a cron job with your own unique time you want to email to be sent, I have mine going off at 6 AM every morning.
