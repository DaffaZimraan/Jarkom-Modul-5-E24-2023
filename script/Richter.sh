apt-get update -y
apt-get install bind9 -y
apt get install netcat

echo '
options {
  directory "/var/cache/bind";
  forwarders {
    192.168.122.1;
  };
  allow-query{any;};

  listen-on-v6 { any; };
};
' > /etc/bind/named.conf.options

service bind9 restart

# no3
iptables -A INPUT -p icmp -m connlimit --connlimit-above 3 --connlimit-mask 0 -j DROP
