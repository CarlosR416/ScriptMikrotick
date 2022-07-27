# mar/13/2022 13:14:22 by RouterOS 6.44.5
# software id = ZLIF-IVXH
#
# model = 750
# serial number = 3B04026230E0
/interface bridge
add comment=defconf name=bridge
/interface ethernet
set [ find default-name=ether1 ] arp=proxy-arp
/interface l2tp-client
add connect-to=194.195.223.242 disabled=no name=l2tp-out1 password=8891957 \
    user=ppp13

/interface list
add comment=defconf name=WAN
add comment=defconf name=LAN

/ip hotspot user profile
set [ find default=yes ] shared-users=3

add !idle-timeout mac-cookie-timeout=1d name=Hora on-login="{\r\
    \n\r\
    \n#tiempo en segundos de duracion\r\
    \n:local tiempo \"259200\"\r\
    \n\r\
    \n# Si la constante asmac esta en 0 se asocia la mac al ticket\r\
    \n:local asmac 0\r\
    \n\r\
    \n:global EpochTime do={\r\
    \n\t# Usage\r\
    \n\t# \$EpochTime [time input]\r\
    \n\t# -----\r\
    \n\t# Get current time\r\
    \n\t# :put [\$EpochTime]\r\
    \n\t# \r\
    \n\t# Read log time in one of these two format \"may/01 16:23:50\" or \"12\
    :02:23\" for log number *323\r\
    \n\t# :put [\$EpochTime [:log get *323 time]]\r\
    \n\r\
    \n\t:local ds\r\
    \n\t:local ts\r\
    \n\tif ([:len \$1]=0) do={\r\
    \n\t\t# Get \"now time\"\r\
    \n\t\t:set ds [/system clock get date]\r\
    \n\t\t:set ts [/system clock get time]\r\
    \n\t} else={\r\
    \n\t\r\
    \n\t\tif ([:len \$1]>8) do={\r\
    \n\t\t\t# Use remote date and time and convert date\r\
    \n\t\t\t:set ds \"\$[:pick \$1 0 6]/\$[:pick [/system clock get date] 7 11\
    ]\"\r\
    \n\t\t\t:set ts [:pick \$1 7 15]\r\
    \n\t\t} else={\r\
    \n\t\t\t# Use remote time and get date\r\
    \n\t\t\t:set ds [/system clock get date]\r\
    \n\t\t\t:set ts \$1\r\
    \n\t\t}\r\
    \n\t}\r\
    \n\t:local months\r\
    \n\t:if ((([:pick \$ds 9 11]-1)/4) != (([:pick \$ds 9 11])/4)) do={\r\
    \n\r\
    \n\t\t:set months {\"an\"=0;\"eb\"=31;\"ar\"=60;\"pr\"=91;\"ay\"=121;\"un\
    \"=152;\"ul\"=182;\"ug\"=213;\"ep\"=244;\"ct\"=274;\"ov\"=305;\"ec\"=335}\
    \r\
    \n\t} else={\r\
    \n\t\t:set months {\"an\"=0;\"eb\"=31;\"ar\"=59;\"pr\"=90;\"ay\"=120;\"un\
    \"=151;\"ul\"=181;\"ug\"=212;\"ep\"=243;\"ct\"=273;\"ov\"=304;\"ec\"=334}\
    \r\
    \n\t}\r\
    \n\t:set ds (([:pick \$ds 9 11]*365)+(([:pick \$ds 9 11]-1)/4)+(\$months->\
    [:pick \$ds 1 3])+[:pick \$ds 4 6])\r\
    \n\t:set ts (([:pick \$ts 0 2]*60*60)+([:pick \$ts 3 5]*60)+[:pick \$ts 6 \
    8])\r\
    \n\t:return (\$ds*24*60*60 + \$ts + 946684800)\r\
    \n}\r\
    \n\r\
    \n:local u \$user\r\
    \n:local marca [\$EpochTime]\r\
    \n:local P6oHA7pLvicrO8ub2fa2 [/ip hotspot user get \$u comment]\r\
    \n\r\
    \n:local t1x3SUqugohIpoc4o3En ([:find \$P6oHA7pLvicrO8ub2fa2 \"Cdate-\"])\
    \r\
    \n\r\
    \n:if ([:typeof \$t1x3SUqugohIpoc4o3En]=\"nil\") do={\r\
    \n\r\
    \n    :local marca2 ([:tonum \$marca]+\$tiempo)\r\
    \n\r\
    \n    :local coment \"Cdate-\$marca2\"\r\
    \n\r\
    \n    [/ip hotspot user set \$u comment=\$coment ]\r\
    \n\r\
    \n\tif (\$asmac=0) do={\r\
    \n\t\t:local act [/ip hotspot active find user=\$u]\r\
    \n\t\t:local mac [/ip hotspot active get (\$act->0) mac-address]\r\
    \n    \t[/ip hotspot user set \$u mac-address=\$mac]\r\
    \n\t}\r\
    \n\r\
    \n} else={\r\
    \n\r\
    \n    :local marca2 [ :pick \$P6oHA7pLvicrO8ub2fa2 6 [:len \$P6oHA7pLvicrO\
    8ub2fa2]]\r\
    \n\r\
    \n    :local newmarca (\$marca2-\$marca)\r\
    \n\r\
    \n    :if (\$newmarca < 1) do={\r\
    \n        set \$newmarca 2\r\
    \n        [/ip hotspot user set \$u limit-uptime=[:tonum \$newmarca]]\r\
    \n        :local act [/ip hotspot active find user=\$u]\r\
    \n        [/ip hotspot active remove (\$act->0)]\r\
    \n    }\r\
    \n\r\
    \n}\r\
    \n\r\
    \n\r\
    \n}" transparent-proxy=yes

    add !idle-timeout mac-cookie-timeout=1d name=24Horas on-login="{\r\
    \n\r\
    \n#tiempo en segundos de duracion\r\
    \n:local tiempo \"604800\"\r\
    \n\r\
    \n# Si la constante asmac esta en 0 se asocia la mac al ticket\r\
    \n:local asmac 0\r\
    \n\r\
    \n:global EpochTime do={\r\
    \n\t# Usage\r\
    \n\t# \$EpochTime [time input]\r\
    \n\t# -----\r\
    \n\t# Get current time\r\
    \n\t# :put [\$EpochTime]\r\
    \n\t# \r\
    \n\t# Read log time in one of these two format \"may/01 16:23:50\" or \"12\
    :02:23\" for log number *323\r\
    \n\t# :put [\$EpochTime [:log get *323 time]]\r\
    \n\r\
    \n\t:local ds\r\
    \n\t:local ts\r\
    \n\tif ([:len \$1]=0) do={\r\
    \n\t\t# Get \"now time\"\r\
    \n\t\t:set ds [/system clock get date]\r\
    \n\t\t:set ts [/system clock get time]\r\
    \n\t} else={\r\
    \n\t\r\
    \n\t\tif ([:len \$1]>8) do={\r\
    \n\t\t\t# Use remote date and time and convert date\r\
    \n\t\t\t:set ds \"\$[:pick \$1 0 6]/\$[:pick [/system clock get date] 7 11\
    ]\"\r\
    \n\t\t\t:set ts [:pick \$1 7 15]\r\
    \n\t\t} else={\r\
    \n\t\t\t# Use remote time and get date\r\
    \n\t\t\t:set ds [/system clock get date]\r\
    \n\t\t\t:set ts \$1\r\
    \n\t\t}\r\
    \n\t}\r\
    \n\t:local months\r\
    \n\t:if ((([:pick \$ds 9 11]-1)/4) != (([:pick \$ds 9 11])/4)) do={\r\
    \n\r\
    \n\t\t:set months {\"an\"=0;\"eb\"=31;\"ar\"=60;\"pr\"=91;\"ay\"=121;\"un\
    \"=152;\"ul\"=182;\"ug\"=213;\"ep\"=244;\"ct\"=274;\"ov\"=305;\"ec\"=335}\
    \r\
    \n\t} else={\r\
    \n\t\t:set months {\"an\"=0;\"eb\"=31;\"ar\"=59;\"pr\"=90;\"ay\"=120;\"un\
    \"=151;\"ul\"=181;\"ug\"=212;\"ep\"=243;\"ct\"=273;\"ov\"=304;\"ec\"=334}\
    \r\
    \n\t}\r\
    \n\t:set ds (([:pick \$ds 9 11]*365)+(([:pick \$ds 9 11]-1)/4)+(\$months->\
    [:pick \$ds 1 3])+[:pick \$ds 4 6])\r\
    \n\t:set ts (([:pick \$ts 0 2]*60*60)+([:pick \$ts 3 5]*60)+[:pick \$ts 6 \
    8])\r\
    \n\t:return (\$ds*24*60*60 + \$ts + 946684800)\r\
    \n}\r\
    \n\r\
    \n:local u \$user\r\
    \n:local marca [\$EpochTime]\r\
    \n:local P6oHA7pLvicrO8ub2fa2 [/ip hotspot user get \$u comment]\r\
    \n\r\
    \n:local t1x3SUqugohIpoc4o3En ([:find \$P6oHA7pLvicrO8ub2fa2 \"Cdate-\"])\
    \r\
    \n\r\
    \n:if ([:typeof \$t1x3SUqugohIpoc4o3En]=\"nil\") do={\r\
    \n\r\
    \n    :local marca2 ([:tonum \$marca]+\$tiempo)\r\
    \n\r\
    \n    :local coment \"Cdate-\$marca2\"\r\
    \n\r\
    \n    [/ip hotspot user set \$u comment=\$coment ]\r\
    \n\r\
    \n\tif (\$asmac=0) do={\r\
    \n\t\t:local act [/ip hotspot active find user=\$u]\r\
    \n\t\t:local mac [/ip hotspot active get (\$act->0) mac-address]\r\
    \n    \t[/ip hotspot user set \$u mac-address=\$mac]\r\
    \n\t}\r\
    \n\r\
    \n} else={\r\
    \n\r\
    \n    :local marca2 [ :pick \$P6oHA7pLvicrO8ub2fa2 6 [:len \$P6oHA7pLvicrO\
    8ub2fa2]]\r\
    \n\r\
    \n    :local newmarca (\$marca2-\$marca)\r\
    \n\r\
    \n    :if (\$newmarca < 1) do={\r\
    \n        set \$newmarca 2\r\
    \n        [/ip hotspot user set \$u limit-uptime=[:tonum \$newmarca]]\r\
    \n        :local act [/ip hotspot active find user=\$u]\r\
    \n        [/ip hotspot active remove (\$act->0)]\r\
    \n    }\r\
    \n\r\
    \n}\r\
    \n\r\
    \n\r\
    \n}" transparent-proxy=yes

add !idle-timeout mac-cookie-timeout=1d name=Mes on-login="# Se debe ejecu\
    tar el script queue basico\r\
    \n\r\
    \n\r\
    \n:local tiempo 0;\r\
    \n:delay 3000ms;\r\
    \n\r\
    \n# Array con los meses\r\
    \n:local months (\"jan\",\"feb\",\"mar\",\"apr\",\"may\",\"jun\",\"jul\",\
    \"aug\",\"sep\",\"oct\",\"nov\",\"dec\");\r\
    \n# Array con los dias de los meses\r\
    \n:local monthsdias (31 ,28 , 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);\r\
    \n#si es a\F1o visiento\r\
    \n:if (([:tonum \$year] % 4) = 0) do={  \r\
    \n\tset \$monthsdias (31 ,29 , 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);\r\
    \n}\r\
    \n\r\
    \n\r\
    \n# get current date\r\
    \n:local date [/system clock get date ];\r\
    \n\r\
    \n# extract month from date\r\
    \n:local datemonth [:pick \$date 0 3 ];\r\
    \n# extract year\r\
    \n:local year [:pick \$date 7 11 ];\r\
    \n\r\
    \n:local day [:pick \$date 4 6 ];\r\
    \n\r\
    \n\r\
    \n#funcion para marca de tiempo\r\
    \n:global EpochTime do={\r\
    \n\t# Usage\r\
    \n\t# \$EpochTime [time input]\r\
    \n\t# -----\r\
    \n\t# Get current time\r\
    \n\t# :put [\$EpochTime]\r\
    \n\t# \r\
    \n\t# Read log time in one of these two format \"may/01 16:23:50\" or \"12\
    :02:23\" for log number *323\r\
    \n\t# :put [\$EpochTime [:log get *323 time]]\r\
    \n\r\
    \n\t:local ds\r\
    \n\t:local ts\r\
    \n\tif ([:len \$1]=0) do={\r\
    \n\t\t# Get \"now time\"\r\
    \n\t\t:set ds [/system clock get date]\r\
    \n\t\t:set ts [/system clock get time]\r\
    \n\t} else={\r\
    \n\t\r\
    \n\t\tif ([:len \$1]>8) do={\r\
    \n\t\t\t# Use remote date and time and convert date\r\
    \n\t\t\t:set ds \"\$[:pick \$1 0 6]/\$[:pick [/system clock get date] 7 11\
    ]\"\r\
    \n\t\t\t:set ts [:pick \$1 7 15]\r\
    \n\t\t} else={\r\
    \n\t\t\t# Use remote time and get date\r\
    \n\t\t\t:set ds [/system clock get date]\r\
    \n\t\t\t:set ts \$1\r\
    \n\t\t}\r\
    \n\t}\r\
    \n\t:local months\r\
    \n\t:if ((([:pick \$ds 9 11]-1)/4) != (([:pick \$ds 9 11])/4)) do={\r\
    \n\r\
    \n\t\t:set months {\"an\"=0;\"eb\"=31;\"ar\"=60;\"pr\"=91;\"ay\"=121;\"un\
    \"=152;\"ul\"=182;\"ug\"=213;\"ep\"=244;\"ct\"=274;\"ov\"=305;\"ec\"=335}\
    \r\
    \n\t} else={\r\
    \n\t\t:set months {\"an\"=0;\"eb\"=31;\"ar\"=59;\"pr\"=90;\"ay\"=120;\"un\
    \"=151;\"ul\"=181;\"ug\"=212;\"ep\"=243;\"ct\"=273;\"ov\"=304;\"ec\"=334}\
    \r\
    \n\t}\r\
    \n\t:set ds (([:pick \$ds 9 11]*365)+(([:pick \$ds 9 11]-1)/4)+(\$months->\
    [:pick \$ds 1 3])+[:pick \$ds 4 6])\r\
    \n\t:set ts (([:pick \$ts 0 2]*60*60)+([:pick \$ts 3 5]*60)+[:pick \$ts 6 \
    8])\r\
    \n\t:return (\$ds*24*60*60 + \$ts + 946684800)\r\
    \n}\r\
    \n#fin de funcion para marca de tiempo\r\
    \n\r\
    \n# Si tiempo es definido en 0 la fecha de corte es el siguente mes el mis\
    mo dia.\r\
    \nif (\$tiempo=0) do={\r\
    \n\r\
    \n\r\
    \n\t\t:local mes ([ :find \$months \$datemonth -1 ] + 1);\r\
    \n\r\
    \n\t\t#tiempo en segundos de duracion\r\
    \n\t\tset \$tiempo ([:pick \$monthsdias (\$mes-1)]*24*3600);\r\
    \n\r\
    \n}\r\
    \n\r\
    \n# Si tiempo es definido en 1 la fecha de corte es en el final del mes.\r\
    \nif (\$tiempo=1) do={\r\
    \n\r\
    \n\r\
    \n\t\t:local mes ([ :find \$months \$datemonth -1 ] + 1);\r\
    \n\r\
    \n\t\t#tiempo en segundos de duracion\r\
    \n\t\tset \$tiempo (([:pick \$monthsdias (\$mes-1)]-\$day)*24*3600);\r\
    \n\r\
    \n}\r\
    \n\r\
    \n#obtenemos datos del usuario del ticket\r\
    \n:local u \$user\r\
    \n:local act [/ip hotspot active find user=\$u]\r\
    \n:local mac [/ip hotspot active get (\$act->0) mac-address]\r\
    \n:local addr [/ip hotspot active get (\$act->0) address]\r\
    \n\r\
    \n#carga la mac al ticket\r\
    \n[/ip hotspot user set \$u mac-address=\$mac]\r\
    \n\r\
    \n#generamos la marca de tiempo\r\
    \n:local marca ([\$EpochTime] + \$tiempo)\r\
    \n\r\
    \n#permitir trafico\r\
    \n[/ip hotspot ip-binding add mac-address=\$mac  comment=\"FV - \$marca - \
    \$u\" type=\"bypassed\"]\r\
    \n\r\
    \n#Enlazar mac al ticket\r\
    \n[/ip hotspot user set \$u mac-address=\$mac]\r\
    \n\r\
    \n#Marcamos al ticket\r\
    \n[/ip hotspot user set \$u comment=\"FV - \$marca - \$u\" ]" transparent-proxy=yes


/ip hotspot profile
set [ find default=yes ] dns-name=zonawifi.com html-directory=hotspot1 \
    http-proxy=0.0.0.0:2909 login-by=cookie,http-chap
/ip pool
add name=default-dhcp ranges=192.168.88.10-192.168.88.254

/ip dhcp-server
add address-pool=default-dhcp disabled=no interface=bridge name=defconf
/ip hotspot
add address-pool=default-dhcp disabled=no idle-timeout=2m interface=bridge \
    name=server1
/queue type
add kind=pcq name=down-pcq pcq-burst-rate=2M pcq-burst-threshold=1500k \
    pcq-burst-time=6s pcq-classifier=dst-address pcq-rate=1M
add kind=pcq name=up-pcq pcq-classifier=src-address pcq-rate=768k

/queue tree
add comment=download-padre limit-at=8M max-limit=10M name=0-download-padre \
    packet-mark="download Global" parent=global queue=pcq-download-default
add comment=upload-padre limit-at=3M max-limit=5M name=0-upload-padre \
    packet-mark="upload Global" parent=global queue=pcq-upload-default


add limit-at=8M max-limit=10M name=download-rest packet-mark=download-rest \
    parent=0-download-padre queue=down-pcq
add limit-at=3M max-limit=5M name=upload-rest packet-mark=upload-rest parent=\
    0-upload-padre queue=up-pcq 

/interface bridge port
add bridge=bridge comment=defconf interface=ether2
add bridge=bridge comment=defconf interface=ether3
add bridge=bridge comment=defconf interface=ether4
add bridge=bridge comment=defconf interface=ether5

/interface list member
add comment=defconf interface=bridge list=LAN
add comment=defconf interface=ether1 list=WAN
/ip address
add address=192.168.88.1/24 comment=defconf interface=bridge network=\
    192.168.88.0
/ip dhcp-client
add comment=defconf dhcp-options=hostname,clientid disabled=no interface=\
    ether1

/ip dhcp-server network
add address=192.168.88.0/24 comment=defconf gateway=192.168.88.1
/ip dns
set allow-remote-requests=yes

/ip firewall filter
add action=accept chain=input comment="Acceso Remoto" in-interface=all-ppp
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=accept chain=input comment=\
    "defconf: accept established,related,untracked" connection-state=\
    established,related,untracked
add action=drop chain=input comment="defconf: drop invalid" connection-state=\
    invalid
add action=accept chain=input comment="defconf: accept ICMP" protocol=icmp
add chain=input disabled=yes in-interface=ether1 protocol=tcp src-port=8291
add action=drop chain=input comment="defconf: drop all not coming from LAN" \
    disabled=yes in-interface-list=!LAN
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
    connection-state=new disabled=yes in-interface-list=WAN
/ip firewall mangle
add action=change-ttl chain=postrouting comment=Bl dst-address=\
    192.168.88.0/24 new-ttl=set:1 packet-mark="" \
    passthrough=yes


add action=mark-packet chain=postrouting comment=download-queue \
    new-packet-mark="download Global" out-interface=bridge passthrough=yes
add action=mark-packet chain=postrouting comment="resto download" \
    new-packet-mark=download-rest out-interface=bridge passthrough=no
add action=mark-packet chain=prerouting comment=upload-queue in-interface=\
    bridge new-packet-mark="upload Global" passthrough=yes
add action=mark-packet chain=prerouting comment="resto upload" in-interface=\
    bridge new-packet-mark=upload-rest passthrough=no
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=masquerade chain=srcnat comment="defconf: masquerade" \
    ipsec-policy=out,none out-interface-list=WAN

/system clock
set time-zone-autodetect=no time-zone-name=America/Caracas

/system scheduler

add interval=5m5s name=cortar on-event="Cortar tickets" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=jan/15/2022 start-time=17:15:41

/system script

add dont-require-permissions=no name=Carga owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="[\
    \r\
    \n    :local length 0\r\
    \n    :local plan \"Hora\"\r\
    \n    :local tiempo \"01:00:01\"\r\
    \n    :local filetotal 1\r\
    \n\r\
    \n    :for f from=1 to=\$filetotal step=1 do={\r\
    \n\r\
    \n        :local namefile (\"tickets\". \$f .\".txt\")\r\
    \n        /log info \$namefile\r\
    \n        /log info \$f\r\
    \n        :local file [/file get \$namefile contents] \r\
    \n        :set length [:len \$file]\r\
    \n        /log info \$file\r\
    \n        :for i from=0 to=\$length step=10 do={\r\
    \n            :local ini \$i\r\
    \n            :local fin ([:tonum \$i]+8)\r\
    \n            :local u [:pick \$file \$ini \$fin]\r\
    \n            /ip hotspot user add name=\$u profile=\$plan limit-uptime=\$\
    tiempo  \r\
    \n        }\r\
    \n    }\r\
    \n]"

add dont-require-permissions=no name="Cortar tickets" owner=admin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    global EpochTime do={\r\
    \n\t# Usage\r\
    \n\t# \$EpochTime [time input]\r\
    \n\t# -----\r\
    \n\t# Get current time\r\
    \n\t# :put [\$EpochTime]\r\
    \n\t# \r\
    \n\t# Read log time in one of these two format \"may/01 16:23:50\" or \"12\
    :02:23\" for log number *323\r\
    \n\t# :put [\$EpochTime [:log get *323 time]]\r\
    \n\r\
    \n\t:local ds\r\
    \n\t:local ts\r\
    \n\tif ([:len \$1]=0) do={\r\
    \n\t\t# Get \"now time\"\r\
    \n\t\t:set ds [/system clock get date]\r\
    \n\t\t:set ts [/system clock get time]\r\
    \n\t} else={\r\
    \n\t\r\
    \n\t\tif ([:len \$1]>8) do={\r\
    \n\t\t\t# Use remote date and time and convert date\r\
    \n\t\t\t:set ds \"\$[:pick \$1 0 6]/\$[:pick [/system clock get date] 7 11\
    ]\"\r\
    \n\t\t\t:set ts [:pick \$1 7 15]\r\
    \n\t\t} else={\r\
    \n\t\t\t# Use remote time and get date\r\
    \n\t\t\t:set ds [/system clock get date]\r\
    \n\t\t\t:set ts \$1\r\
    \n\t\t}\r\
    \n\t}\r\
    \n\t:local months\r\
    \n\t:if ((([:pick \$ds 9 11]-1)/4) != (([:pick \$ds 9 11])/4)) do={\r\
    \n\r\
    \n\t\t:set months {\"an\"=0;\"eb\"=31;\"ar\"=60;\"pr\"=91;\"ay\"=121;\"un\
    \"=152;\"ul\"=182;\"ug\"=213;\"ep\"=244;\"ct\"=274;\"ov\"=305;\"ec\"=335}\
    \r\
    \n\t} else={\r\
    \n\t\t:set months {\"an\"=0;\"eb\"=31;\"ar\"=59;\"pr\"=90;\"ay\"=120;\"un\
    \"=151;\"ul\"=181;\"ug\"=212;\"ep\"=243;\"ct\"=273;\"ov\"=304;\"ec\"=334}\
    \r\
    \n\t}\r\
    \n\t:set ds (([:pick \$ds 9 11]*365)+(([:pick \$ds 9 11]-1)/4)+(\$months->\
    [:pick \$ds 1 3])+[:pick \$ds 4 6])\r\
    \n\t:set ts (([:pick \$ts 0 2]*60*60)+([:pick \$ts 3 5]*60)+[:pick \$ts 6 \
    8])\r\
    \n\t:return (\$ds*24*60*60 + \$ts + 946684800)\r\
    \n}\r\
    \n:local actual [:tonum [\$EpochTime]]\r\
    \n:local ids [/ip hotspot ip-binding find]\r\
    \n\r\
    \n:foreach i in=\$ids do={ \r\
    \n    :local cliente [/ip hotspot ip-binding get \$i]\r\
    \n\r\
    \n    \r\
    \n    :if ([:typeof [:find (\$cliente->\"comment\") \"FV\"]]!=\"nil\") do=\
    { \r\
    \n        \r\
    \n        :local vecimiento [:tonum [:pick (\$cliente->\"comment\") 5 15]]\
    ;\r\
    \n        :local ticket  [:pick (\$cliente->\"comment\") 18 26];\r\
    \n        :local coment [:pick (\$cliente->\"comment\") 0 26];\r\
    \n\r\
    \n        :if (\$vecimiento < \$actual) do={\r\
    \n            [/log info \"cortardo \$ticket\"]\r\
    \n            [/ip hotspot user set \$ticket limit-uptime=1 comment=\"\$co\
    ment - Cortado\"]\r\
    \n            [/ip hotspot ip-binding remove \$i]\r\
    \n        } else={\r\
    \n\r\
    \n            :local resto (\$vecimiento - \$actual)\r\
    \n            [/ip hotspot ip-binding set \$i comment=\"\$coment - RESTA: \
    \$resto\" ]\r\
    \n        }\r\
    \n\r\
    \n    }\r\
    \n}"

