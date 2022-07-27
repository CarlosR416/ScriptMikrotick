#Script tiempo acumulado v1.0
#Routeros 6.45.9 

#tiempo de Validez en segundos 
:local ValidityTime (24*3600)

#Entrelazamiento mac "si", "no"
:local MacInterlacing "si"

#funcion de array a texto
:local ArrayToText do={
    :local comment ""

    foreach key,value in=$1 do={

        :if ([:typeof $value] = "nil") do={
            set $value "nil"
        }

        :if ($key = 0) do={

            set $comment "$value"

        } else={

            set $comment "$comment, $value"

        }

    }

    :return $comment 
}

#funcion para marca de tiempo
:local timestamp do={
	
        # $timestamp [time input]
        # -----
        # Get current time
        # :put [$timestamp]
        # 
        # Read log time in one of these two format "may/01 16:23:50" or "12:02:23" for log number *323
        # :put [$timestamp [:log get *323 time]]

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


:local CommentText [/ip hotspot user get $user comment]

:local commentArray [:toarray $CommentText]

:local TimeLeft 0

:if (($commentArray->4) != "1") do={

    :set ($commentArray->4) "1"

    :local CurrentTime [$timestamp]
    
    :if (($commentArray->1) = "SCTA-1.0") do={

        :set $TimeLeft ([:tonum ($commentArray->2)]-[:tonum $CurrentTime])

        if ($TimeLeft<1) do={
            :set ($commentArray->3) "CORTADO"
            [/ip hotspot user set $user limit-uptime=2 ]
        }

        :set ($commentArray->5) [:totime $TimeLeft]

    } else={
        :set ($commentArray->1) "SCTA-1.0"
        :set ($commentArray->2) ($CurrentTime+$ValidityTime)
        :set ($commentArray->3) "ACTIVO"
        :set ($commentArray->5) [:totime $ValidityTime]
    }

    [/ip hotspot user set $user comment=[$ArrayToText [$commentArray]] ]

    #Si no se obtiene el usuario asi no funciona jaja 
    :local AS34S $user    
    :local UserActive [/ip hotspot active find user=$AS34S]

    :foreach key,value in=$UserActive do={

        :do {

            :local arg [/ip hotspot active get $value]

            :if ($MacInterlacing="si") do={
                [/ip hotspot user set $user mac-address=($arg->"mac-address")]
            }
            
            [/ip hotspot active remove $value]
            
        } on-error={ 
            /log info "Script Login: failed get active user"
        }
        

    }

} else={
    :set ($commentArray->4) "0"
    [/ip hotspot user set $user comment=[$ArrayToText [$commentArray]] ]
}

