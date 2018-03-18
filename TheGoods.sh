#Mail can't be sent out via port 25 for comcast, need to pivot off of googles smtp server at smtp.gmail.com 587

#!/bin/bash
Apt-get install sharutils
Apt-get install dnsutils
Apt-get install mailutils
myip="$(dig +short myip.opendns.com @resolver1.opendns.com)"
date="$(date '+%A %x %X')"
echo "My WAN/Public IP address on ${date} is: ${myip}" > /MailDump.d
echo "My WAN/Public IP address on ${date} is: ${myip}" >> /MailDump.w
echo "root:example@gmail.com:smtp.gmail.com:587" >> /etc/ssmtp/revaliases
--------------------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------------------
#Finally command
echo -e "to: EXAMPLE.COM\nsubject: EXAMPLE\n"| (cat - && uuencode /MailDump.w MailDump.text) | ssmtp EXAMPLE@gmail.com

