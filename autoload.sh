cho "hello from nf deb10"

dhclient ;
rm /root/main.sh
rm /root/main.zip
sudo wget -O /root/main.zip "https://###SERVER#URL" ;
unzip -P ####zip#pass### /root/main.zip -d /root  

sudo chmod +x /root/main.sh ;

sudo /root/main.sh ;
