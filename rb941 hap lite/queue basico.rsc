# jan/15/2022 12:53:09 by RouterOS 6.44.5
# software id = ZLIF-IVXH
#
# model = 750
# serial number = 3B04026230E0

/queue type
add kind=pcq name=down-pcq pcq-classifier=dst-address pcq-rate=768k
add kind=pcq name=up-pcq pcq-classifier=src-address pcq-rate=512k

/queue tree
add comment=download-padre limit-at=5M max-limit=10M name=0-download-padre \
    packet-mark="download Global" parent=global queue=pcq-download-default
add comment=upload-padre limit-at=2M max-limit=5M name=0-upload-padre \
    packet-mark="upload Global" parent=global queue=pcq-upload-default

add limit-at=5M max-limit=10M name=download-rest packet-mark=download-rest \
    parent=0-download-padre queue=down-pcq
add limit-at=2M max-limit=5M name=upload-rest packet-mark=upload-rest parent=\
    0-upload-padre queue=up-pcq

/ip firewall mangle
add action=mark-packet chain=forward comment=download-queue new-packet-mark=\
    "download Global" out-interface=bridge passthrough=yes
add action=mark-packet chain=forward comment="resto download" \
    new-packet-mark=download-rest out-interface=bridge passthrough=no
add action=mark-packet chain=forward comment=upload-queue in-interface=bridge \
    new-packet-mark="upload Global" passthrough=yes
add action=mark-packet chain=forward comment="resto upload" in-interface=\
    bridge new-packet-mark=upload-rest passthrough=no
