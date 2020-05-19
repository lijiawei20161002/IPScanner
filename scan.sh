ip=$1
file=$2

l1=${ip%%.*}
ip=${ip#*.}
l2=${ip%%.*}
ip=${ip#*.}
l3=${ip%%.*}
ip=${ip#*.}
l4=${ip%%/*}
ip=${ip#*/}
subnet=$ip #mask

if echo "$l1" | grep [^0-9] >/dev/null;
then
   echo "usage: ./scan.sh your_ip_subnet your_savingfile_name"
   exit
fi

if echo "$l2" | grep [^0-9] >/dev/null;
then
   echo "usage: ./scan.sh your_ip_subnet your_savingfile_name"
   exit
fi

if echo "$l3" | grep [^0-9] >/dev/null;
then
   echo "usage: ./scan.sh your_ip_subnet your_savingfile_name"
   exit
fi

if echo "$l4" | grep [^0-9] >/dev/null;
then
   echo "usage: ./scan.sh your_ip_subnet your_savingfile_name"
   exit
fi

if echo "$subnet" | grep [^0-9] >/dev/null;
then
   echo "usage: ./scan.sh your_ip_subnet your_savingfile_name"
   exit
fi

#how many ip in this subnet
subnet=32-$ip
num=$((2**($subnet)))
cnt=0

#scanning
while [ $num -ge 0 ]
do
ip="$l1.$l2.$l3.$l4"
echo "$ip"
nmap $ip | grep "Host is up"
if [ $? == 0 ];
then
   echo $ip>>$file
fi
((num=$num-1))
if(($l4<255))
then
  ((l4=$l4+1))
else
  if(($l3<255))
  then
     ((l3=$l3+1))
  else
     if(($l2<255))
     then
        ((l2=$l2+1))
     else
        ((l1=$l1+1))
     fi
  fi
fi
done
