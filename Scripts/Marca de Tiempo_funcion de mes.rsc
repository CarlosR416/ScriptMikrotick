#Se ejecuta en pla clon
{ 

	:local u $user

	# plan o perfil clon temporal
	:local plan2 "Mes"

	[/ip hotspot user set $u profile=$plan2]

}
{


# plan o perfil clon temporal
:local plan2 "MesC"

# Si la constante tiempo esta en 0 el tiempo sera 1 mes 
:local tiempo 0

# Si la constante asmac esta en 0 se asocia la mac al ticket
:local asmac 0

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

:local u $user
:local act [/ip hotspot active find user=$u]
:local marca [$EpochTime]
:local P6oHA7pLvicrO8ub2fa2 [/ip hotspot user get $u comment]

:local t1x3SUqugohIpoc4o3En ([:find $P6oHA7pLvicrO8ub2fa2 "Cdate-"])

:if ([:typeof $t1x3SUqugohIpoc4o3En]="nil") do={

	if ($tiempo=0) do={

		:local months ("jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec");
		# get current date
		:local date [/system clock get date ];
		# extract month from date
		:local datemonth [:pick $date 0 3 ];
		# extract year
		:local year [:pick $date 7 11 ];

		:local monthsdias (31 ,28 , 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);

		:if (([:tonum $year] % 4) = 0) do={  
			set $monthsdias (31 ,29 , 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
		}

		:local mes ([ :find $months $datemonth -1 ] + 1);

		#tiempo en segundos de duracion
		set $tiempo ([:pick $monthsdias ($mes-1)]*24*3600);

	}
    

    :local marca2 ([:tonum $marca]+$tiempo)

    :local coment "Cdate-$marca2"

    [/ip hotspot user set $u comment=$coment ]
    [/ip hotspot user set $u limit-uptime=[:tonum $tiempo]]
    [/ip hotspot user reset-counters $u]

	if ($asmac=0) do={
		:local mac [/ip hotspot active get ($act->0) mac-address]
    	[/ip hotspot user set $u mac-address=$mac]
	}
    

} else={

    :local marca2 [ :pick $P6oHA7pLvicrO8ub2fa2 6 [:len $P6oHA7pLvicrO8ub2fa2]]

    :local newmarca ($marca2-$marca)
    
    :if ($newmarca < 2) do={
        set $newmarca 1
    }
   
    [/ip hotspot user set $u limit-uptime=[:tonum $newmarca]]
    [/ip hotspot user reset-counters $u]
    
}
    [/ip hotspot user set $u profile=$plan2]
	:local addr [/ip hotspot active get ($act->0) address]
    [/ip hotspot active remove ($act->0)]
	[/ip hotspot active login ip=$addr user=$u]
}