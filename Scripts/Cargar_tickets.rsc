[
    :local length 0
    :local plan "prueba"
    :local tiempo "00:10:00"
    :local filetotal 2

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
            /ip hotspot user add name=$u profile=$plan limit-uptime=$tiempo  
        }
    }
]