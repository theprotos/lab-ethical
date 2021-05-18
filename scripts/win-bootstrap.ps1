echo "  --> Disable eth0"
netsh interface set interface "Ethernet" disable
echo "  --> Setup eth1"
netsh interface ipv4 set address name="Ethernet 2" static 192.168.100.101 255.255.255.0 192.168.100.10
netsh interface ip set dns "Ethernet 2" static 1.1.1.1
#IPv4
netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol="icmpv4:8,any" dir=in action=allow
#IPv6
netsh advfirewall firewall add rule name="ICMP Allow incoming V6 echo request" protocol="icmpv6:8,any" dir=in action=allow