

function getFileFromEtcd {
    baseKey=$1
    for key in  $(etcdctl ls -p --recursive ${baseKey}  | grep -v "/$" )
    do
        filePath=${key#$baseKey}
        echo "$filePath"
        if [ ! -e "$filePath" ]
        then
            echo "[boot] try to get ${filePath}"
            if [ ! -d $(dirname "${filePath}") ]
            then
                mkdir -p $(dirname "${filePath}")
            fi
            etcdctl get "${key}" > "$filePath"
            echo "[boot] get $filePath from etcd"
        fi
    done
}


if [ -z ${DH_SIZE+x} ]
then
  >&2 echo ">> no \$DH_SIZE specified using default" 
  DH_SIZE="1024"
fi

if [ ! -d /etc/nginx/ssl ]
then
	mkdir -p /etc/nginx/ssl
fi

DH="/etc/nginx/ssl/dhparam.pem"

if [ ! -e "$DH" ]
then
    echo "[boot] generating $DH with size: $DH_SIZE"
    openssl dhparam -out "$DH" $DH_SIZE
    cat "$DH" |  etcdctl set "$baseKey$DH"  > /dev/null
fi


PUBLIC="/etc/nginx/ssl/public.crt"
PRIVATE="/etc/nginx/ssl/private.rsa"


if [ ! -e "$PUBLIC" ] || [ ! -e "$PRIVATE" ]
then
    echo "[boot] generating self signed cert"
    openssl req -x509 -newkey rsa:4086 \
      -subj "/C=XX/ST=XXXX/L=XXXX/O=XXXX/CN=localhost" \
      -keyout "$PRIVATE" \
      -out "$PUBLIC" \
      -days 3650 -nodes -sha256
    cat "$PUBLIC" | etcdctl set "$baseKey$PUBLIC"  > /dev/null
    cat "$PRIVATE" | etcdctl set "$baseKey$PRIVATE"  > /dev/null
fi

FULL_CHAIN="/etc/nginx/ssl/full_chain.pem"

if [ ! -e "$FULL_CHAIN" ]
then
    cp "$PUBLIC" "$FULL_CHAIN"
    cat "$FULL_CHAIN" | etcdctl set "$baseKey$FULL_CHAIN"  > /dev/null
  fi
fi

echo "[boot] booting container. ETCD: $ETCDCTL_PEERS"

# Loop until confd has updated the nginx config
until confd -debug -onetime ; do
  echo "[boot] waiting for confd ..."
  sleep 5
done


