echo "  --> Disable eth0"
      netsh interface set interface "Ethernet" disable
      echo "  --> Setup eth1"
      netsh interface ipv4 set address name="Ethernet 2" static 192.168.100.101 255.255.255.0 192.168.100.10
      echo "  --> Setup dns for eth1"
      netsh interface ipv4 set dnsserver "Ethernet 2" static none
      netsh interface ipv4 add dns "Ethernet 2" 1.1.1.1 1
      netsh interface ipv4 add dns "Ethernet 2" 8.8.8.8 2
      echo "  --> enable ICMP for IPv4"
      netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol="icmpv4:8,any" dir=in action=allow
      echo "  --> enable ICMP for IPv6"
      netsh advfirewall firewall add rule name="ICMP Allow incoming V6 echo request" protocol="icmpv6:8,any" dir=in action=allow