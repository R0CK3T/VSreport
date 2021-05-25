
echo "Hello from remote server"
tag=$(whiptail --inputbox "Tag :" 10 30 3>&1 1>&2 2>&3)
serialnumb=`sudo dmidecode -t system | grep Serial  | awk -F ': ' '{ print $2 }'`
datentime=`date +'%d-%m-%Y_%H-%M-%S'`
sudo lshw -html > /root/$tag"_"$serialnumb"_"$datentime.html
#edit ip.add.re.ss and  reporteruser,reporteruserpassword to pass your login credentials
lftp -e "put /root/$tag"_"$serialnumb"_"$datentime.html; quit" sftp://ip.add.re.ss -p 22 -u reporteruser,reporteruserpassword
echo "Done sending..."
