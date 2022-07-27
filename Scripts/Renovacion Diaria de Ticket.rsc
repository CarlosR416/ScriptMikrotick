{

# plan o perfil que debe ejecutar el script
:local plan "Hora"

# plan o perfil clon sin evento que debe ejecutar el script
:local plan2 "HoraC"

#tiempo en segundos de duracion
:local tiempo "86400"

:local user "ROSA0102"

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

:local marca [$EpochTime]
:local P6oHA7pLvicrO8ub2fa2 [/ip hotspot user get $user comment]

:local t1x3SUqugohIpoc4o3En ([:find $P6oHA7pLvicrO8ub2fa2 "Cdate-"])

:if ([:typeof $t1x3SUqugohIpoc4o3En]="nil") do={

    :local marca2 ([:tonum $marca]+$tiempo)

    :local coment "Cdate-$marca2"

    [/ip hotspot user set $user comment=$coment ]

} else={

    :local marca2 [ :pick $P6oHA7pLvicrO8ub2fa2 6 [:len $P6oHA7pLvicrO8ub2fa2]]

    :local newmarca ($marca2-$marca)

    :if ($newmarca < 1) do={
        
        :local marca ([:tonum $marca2]+$tiempo)

        :local coment "Cdate-$marca"

        [/ip hotspot user set $user comment=$coment ]

        [/ip hotspot user reset-counters $user]
    }

}

#:local active [/ip hotspot active find user=$user]
#:local ipactive [/ip hotspot active get $active address]
#:local nameuser [/ip hotspot active get $active user]

#[/ip hotspot user set $user profile=$plan2]
#[/ip hotspot active remove $active]
#[/ip hotspot active login ip=$ipactive user=$nameuser]
#[/ip hotspot user set $user profile=$plan]

}