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

#echo cpu
#cat /proc/cpuinfo | grep -m 1  "model name"
#echo
#echo memory
#sudo dmidecode --type 17 | cut -c 2- | grep ^"Size: "
#sudo dmidecode --type 17 | cut -c 2- | grep ^"Type:"
#sudo dmidecode --type 17 | cut -c 2- | grep ^"Locator: "
#echo
#echo disks
#sudo nvme list -o=json | tr -d '"' | tr -d ','| grep ModelNumber | cut -c 7-
#sudo nvme list -o=json | tr -d '"' | tr -d ','| grep SerialNumber | cut -c 7-
#sudo nvme list -o=json | tr -d '"' | tr -d ','| grep PhysicalSize | cut -c 7-
#echo
#echo battery
#upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep model | sed 's/  //g'
#upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep serial | sed 's/  //g'
#echo


sudo lshw -html > /root/reports/$reportname
#edit ip.add.re.ss and  reporteruser,reporteruserpassword to add your login 
lftp -e "put /root/reports/$reportname; quit" -u "reporteruser","reporteruserpassword"  sftp://ip.add.re.ss
if [ "$?" = "0" ]
then
        echo "done sending !"
else
        echo "fail sending ..."
fi

