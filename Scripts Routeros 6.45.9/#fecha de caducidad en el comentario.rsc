#fecha de caducidad en el comentario

#funcion marca de tiempo a fecha v1.0
#routeros 6.45.9
:local timestampToDate do={
	
	:local ttime 0
    :local tdia 0
    :local tmes "Ene"
    :local tano 0
    :local bisiesto 0

    :local timestamp [:tonum $1]
    #:local timestamp (1658600325+(8*24*3600))

	:if ([:typeof $timestamp]="num") do={
		
        :set $timestamp ($timestamp-946684800)
        :set $ttime ($timestamp%86400)

        :set $timestamp ($timestamp-$ttime)

        :if ($timestamp>0) do={
            :set $timestamp ($timestamp/86400)
            :set $tdia (($timestamp%365))
            :set $timestamp ($timestamp-$tdia)
        }

        :if ($timestamp>0) do={
            :set $tano ($timestamp/365)
            :set $bisiesto (($tano-($tano%4))/4) 
        }

        :set $tdia ($tdia-$bisiesto)
        
        :local months
        :if (($tano%4) = 0) do={
            :set months {"Ene"=0;"Feb"=31;"Mar"=60;"Abr"=91;"May"=121;"Jun"=152;"Jul"=182;"Ago"=213;"Sep"=244;"Oct"=274;"Nov"=305;"Dic"=335}
        } else={
            :set months {"Ene"=0;"Feb"=31;"Mar"=59;"Abr"=90;"May"=120;"Jun"=151;"Jul"=181;"Ago"=212;"Sep"=243;"Oct"=273;"Nov"=304;"Dic"=334}
        }
        
        :foreach key,value in=$months do={ 
            
            :if ($value<=$tdia && (($months->[$tmes]) < $value)) do={
                :set tmes $key
            }
            
        }

        :set $tdia ($tdia-($months->[$tmes]))

        :if ($tdia = 0) do={
            :set $tdia 1
        }

	}
    :set $ttime [:totime $ttime]
    
    :return "$tdia/$tmes/$tano $ttime"
}

:local usr [/ip hotspot user find];


foreach i in=$usr do={
    
    :local u [/ip hotspot user get $i];
    :local P6oHA7pLvicrO8ub2fa2 ($u->"comment");

    :local t1x3SUqugohIpoc4o3En ([:find $P6oHA7pLvicrO8ub2fa2 "FV"]);

    :if ([:typeof $t1x3SUqugohIpoc4o3En]!="nil") do={

        :local marca2 [ :pick $P6oHA7pLvicrO8ub2fa2 5 15];

        :local newmarca [$timestampToDate [$marca2]];
    
           
        [/ip hotspot user set $i comment="$P6oHA7pLvicrO8ub2fa2 - Caduca: $newmarca"]
        

       
    }


}
