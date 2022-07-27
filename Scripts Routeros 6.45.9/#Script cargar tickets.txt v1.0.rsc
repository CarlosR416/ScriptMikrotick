#Script cargar tickets.txt v1.0
#Routeros 6.45.9

[
    :local length 0
    :local plan "prueba"
    :local tiempo "00:10:00"
    :local filetotal 2
    :local PrefixComment ""

    # z=hoja x=fila y=columna {z;x;y}
    :local DimensionesTickets {248;8;31}


    :local IT 0
    :local x 1
    :local y 1
    :local z 1

    :for f from=1 to=$filetotal step=1 do={

        :local namefile ("tickets". $f .".txt")
        /log info $namefile
        /log info $f
        :local file [/file get $namefile contents] 
        :set length [:len $file]
        /log info $file
        :for i from=0 to=$length step=10 do={
            :local ini $i
            :local fin ([:tonum $i]+8)
            :local u [:pick $file $ini $fin]
            :set $IT ($IT+1)            
            [/ip hotspot user add name=$u profile=$plan limit-uptime=$tiempo comment="$PrefixComment:$z:$x:$y"]

            :if ($IT%($DimensionesTickets->1) = 0) do={
                :set $x 0
                :set $y ($y+1)
            }

            :set $x ($x+1)

            :if ($IT%($DimensionesTickets->0) = 0) do={
                :set $z ($z+1)
                :set $x 1
                :set $y 1
            }  
        }
    }
]