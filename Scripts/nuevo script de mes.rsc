
:local tiempo 1;
:delay 3000ms;

# Array con los meses
:local months ("jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec");
# Array con los dias de los meses
:local monthsdias (31 ,28 , 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
#si es año visiento
:if (([:tonum $year] % 4) = 0) do={  
	set $monthsdias (31 ,29 , 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
}


# get current date
:local date [/system clock get date ];

# extract month from date
:local datemonth [:pick $date 0 3 ];
# extract year
:local year [:pick $date 7 11 ];

:local day [:pick $date 4 6 ];


#funcion para marca de tiempo
:global EpochTime do={
	# Usage
	# $EpochTime [time input]
	# -----
	# Get current time
	# :put [$EpochTime]
	# 
	# Read log time in one of these two format "may/01 16:23:50" or "12:02:23" for log number *323
	# :put [$EpochTime [:log get *323 time]]

	:local ds
	:local ts
	if ([:len $1]=0) do={
		# Get "now time"
		:set ds [/system clock get date]
		:set ts [/system clock get time]
	} else={
	
		if ([:len $1]>8) do={
			# Use remote date and time and convert date
			:set ds "$[:pick $1 0 6]/$[:pick [/system clock get date] 7 11]"
			:set ts [:pick $1 7 15]
		} else={
			# Use remote time and get date
			:set ds [/system clock get date]
			:set ts $1
		}
	}
	:local months
	:if ((([:pick $ds 9 11]-1)/4) != (([:pick $ds 9 11])/4)) do={

		:set months {"an"=0;"eb"=31;"ar"=60;"pr"=91;"ay"=121;"un"=152;"ul"=182;"ug"=213;"ep"=244;"ct"=274;"ov"=305;"ec"=335}
	} else={
		:set months {"an"=0;"eb"=31;"ar"=59;"pr"=90;"ay"=120;"un"=151;"ul"=181;"ug"=212;"ep"=243;"ct"=273;"ov"=304;"ec"=334}
	}
	:set ds (([:pick $ds 9 11]*365)+(([:pick $ds 9 11]-1)/4)+($months->[:pick $ds 1 3])+[:pick $ds 4 6])
	:set ts (([:pick $ts 0 2]*60*60)+([:pick $ts 3 5]*60)+[:pick $ts 6 8])
	:return ($ds*24*60*60 + $ts + 946684800)
}
#fin de funcion para marca de tiempo

# Si tiempo es definido en 0 la fecha de corte es el siguente mes el mismo dia.
if ($tiempo=0) do={


		:local mes ([ :find $months $datemonth -1 ] + 1);

		#tiempo en segundos de duracion
		set $tiempo ([:pick $monthsdias ($mes-1)]*24*3600);

}

# Si tiempo es definido en 1 la fecha de corte es en el final del mes.
if ($tiempo=1) do={


		:local mes ([ :find $months $datemonth -1 ] + 1);

		#tiempo en segundos de duracion
		set $tiempo (([:pick $monthsdias ($mes-1)]-$day+1)*24*3600);

}

#obtenemos datos del usuario del ticket
:local u $user
:local act [/ip hotspot active find user=$u]
:local mac [/ip hotspot active get ($act->0) mac-address]
:local addr [/ip hotspot active get ($act->0) address]

#carga la mac al ticket
[/ip hotspot user set $u mac-address=$mac]

#generamos la marca de tiempo
:local marca ([$EpochTime] + $tiempo)

#permitir trafico
[/ip hotspot ip-binding add mac-address=$mac  comment="FV - $marca - $u" type="bypassed"]

#Enlazar mac al ticket
[/ip hotspot user set $u mac-address=$mac]

#Marcamos al ticket
[/ip hotspot user set $u comment="FV - $marca - $u" ]