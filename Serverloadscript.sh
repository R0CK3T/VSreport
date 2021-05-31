echo "Hello from remote server"
tag=$(whiptail --inputbox "Tag :" 10 30 3>&1 1>&2 2>&3)
serialnumb=`sudo dmidecode -t system | grep Serial  | awk -F ': ' '{ print $2 }'`
datentime=`date +'%d-%m-%Y_%H-%M-%S'`
mkdir /root/reports
if [ "$serialnumb" = "Not Specified" ]
then
        reportname=$tag"_unknow_"$datentime.html
else
        reportname=$tag"_"$serialnumb"_"$datentime.html
fi
sudo lshw -html > /root/reports/$reportname
#edit ip.add.re.ss and  reporteruser,reporteruserpassword to add your login 
lftp -e "put /root/reports/$reportname; quit" -u "reporteruser","reporteruserpassword"  sftp://ip.add.re.ss
if [ "$?" = "0" ]
then
        echo "done sending !"
else
        echo "fail sending ..."
fi

