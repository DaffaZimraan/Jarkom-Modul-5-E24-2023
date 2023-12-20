echo nameserver 192.218.0.6 >> /etc/resolv.conf

apt get update -y
apt get install netcat -y

# no4
iptables -A INPUT -p tcp --dport 22 -s 192.218.4.0/22 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j DROP

# no5
iptables -A INPUT -p tcp --dport 22 -m time --weekdays Mon,Tue,Wed,Thu,Fri --timestart 08:00 --timestop 16:00 -s 192.218.4.0/22 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j DROP

# no6
iptables -A INPUT -p tcp --dport 22 -m time --weekdays Mon,Tue,Wed,Thu --timestart 12:00 --timestop 13:00 -j DROP
iptables -A INPUT -p tcp --dport 22 -m time --weekdays Fri --timestart 11:00 --timestop 13:00 -j DROP
iptables -A INPUT -p tcp --dport 22 -m time --weekdays Mon,Tue,Wed,Thu,Fri --timestart 08:00 --timestop 16:00 -s 192.218.4.0/22 -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j DROP

# no8
iptables -A INPUT -p tcp --dport 80 -m time --datestart "2024-02-14T00:00" --datestop "2024-06-26T23:59" -s 192.218.0.0/30 -j DROP

# no 9
iptables -N tab_scan
iptables -A INPUT -m recent --name tab_scan --update --seconds 600 --hitcount 20 -j DROP
iptables -A FORWARD -m recent --name tab_scan --update --seconds 600 --hitcount 20 -j DROP
iptables -A INPUT -m recent --name tab_scan --set -j ACCEPT
iptables -A FORWARD -m recent --name tab_scan --set -j ACCEPT
