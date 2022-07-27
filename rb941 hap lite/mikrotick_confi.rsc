# feb/18/2021 01:30:52 by RouterOS 6.47.9
# software id = 4WHD-018V
#
# model = RB941-2nD
# serial number = D0560EAFF21B
/interface bridge
add auto-mac=yes comment=defconf name=bridge


/interface list
add comment=defconf name=WAN
add comment=defconf name=LAN

/ip hotspot profile
set [ find default=yes ] dns-name=zonawifi.com html-directory=zonawifi.com


/ip pool
add name=default-dhcp ranges=192.168.88.10-192.168.88.254
/ip dhcp-server
add address-pool=default-dhcp disabled=no interface=bridge name=defconf
/ip hotspot
add address-pool=default-dhcp addresses-per-mac=unlimited disabled=no \
    idle-timeout=none interface=bridge name=server1
/user group
set full policy="local,telnet,ssh,ftp,reboot,read,write,policy,test,winbox,pas\
    sword,web,sniff,sensitive,api,romon,dude,tikapp"
/interface bridge port
add bridge=bridge comment=defconf interface=ether2
add bridge=bridge comment=defconf interface=ether3
add bridge=bridge comment=defconf interface=ether4
add bridge=bridge comment=defconf interface=wlan1
/ip neighbor discovery-settings
set discover-interface-list=LAN
/interface list member
add comment=defconf interface=bridge list=LAN
add comment=defconf interface=ether1 list=WAN
/ip address
add address=192.168.88.1/24 comment=defconf interface=bridge network=\
    192.168.88.0
/ip dhcp-client
add comment=defconf disabled=no interface=ether1
/ip dhcp-server network
add address=192.168.88.0/24 comment=defconf gateway=192.168.88.1
/ip dns
set allow-remote-requests=yes
/ip dns static
add address=192.168.88.1 name=router.lan
/ip firewall filter
add action=accept chain=input in-interface=all-ppp
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=accept chain=input comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=drop chain=input comment="defconf: drop invalid" connection-state=\
    invalid
add action=accept chain=input comment="defconf: accept ICMP" protocol=icmp
add action=drop chain=input comment="defconf: drop all not coming from LAN" \
    in-interface-list=!LAN
add action=accept chain=forward comment="defconf: accept in ipsec policy" \
    ipsec-policy=in,ipsec
add action=accept chain=forward comment="defconf: accept out ipsec policy" \
    ipsec-policy=out,ipsec
add action=fasttrack-connection chain=forward comment="defconf: fasttrack" \
    connection-state=established,related disabled=yes
add action=accept chain=forward comment=\
    "defconf: accept established,related, untracked" connection-state=\
    established,related,untracked
add action=drop chain=forward comment="defconf: drop invalid" \
    connection-state=invalid
add action=drop chain=forward comment=\
    "defconf:  drop all from WAN not DSTNATed" connection-nat-state=!dstnat \
    connection-state=new in-interface-list=WAN
/ip firewall mangle
add action=change-ttl chain=postrouting dst-address=192.168.88.0/24 new-ttl=\
    set:1 passthrough=yes
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=masquerade chain=srcnat comment="defconf: masquerade" \
    ipsec-policy=out,none out-interface-list=WAN
/ip hotspot user
add name=01010101
/system clock
set time-zone-name=America/Caracas
/system scheduler
add interval=1d name=Reiniciar on-event="[/system reboot]" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=may/05/2021 start-time=04:00:00
/system watchdog
set automatic-supout=no watchdog-timer=no
/tool mac-server
set allowed-interface-list=LAN
/tool mac-server mac-winbox
set allowed-interface-list=LAN
