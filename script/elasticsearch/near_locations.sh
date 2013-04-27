#!/bin/bash
#Enter current lacations's latitude and longitude 
area[0]="chandigarh,india"
area[1]="Ambala City, Haryana"
area[2]="Kurukshetra, Haryana"
area[3]="Karnal, Haryana"
area[4]="Panipat, Haryana"
area[5]="Sonipat, Haryana"
area[6]="Delhi, India"
area[7]="Gurgaon, Haryana"
echo "\"${area[0]}\""

lat[0]=30.7353
long[0]=76.7911

lat[1]=30.3800
long[1]=76.7800

lat[2]=30.0000
long[2]=76.7500

lat[3]=29.6800
long[3]=76.9800

lat[4]=29.3900
long[4]=76.9700

lat[5]=28.9800
long[5]=77.0200

lat[6]=29.0167
long[6]=77.3833

lat[7]=28.4700
long[7]=77.0300

#Enter Future time to display in people near or past time to display in history
inc=2
for i in {0..6}
do

for j in {1..7}
do

num=$(($inc+$i + $j))
a=$(date -u +"%Y-%m-%dT%H:%M:%S" --date="$num hour")

if [[ $i -ge $j ]]
then
echo "                  "
continue
else
dtm=\"$dt"T"$tm\"
  from="\"${lat[$i]},${long[$i]}\""
  to="\"${lat[$j]},${long[$j]}\""
echo $from
echo $to
for k in {1..1}
do

curl -XPOST 'http://localhost:9200/static_pages/static_pages/' -d '
{
    "user_name": "Rajan Punchouty",
    "user_id": "100005196784043",
    "from": '"\"${area[$i]}\""',
    "from_location": '$from',
    "to": '"\"${area[$j]}\""',
    "to_location": '$to',
    "date_at":'"\"$a\""',
    "have_car":"false",
    "distance_time":"255.109,245"
}'

done


for k in {1..1}
do

curl -XPOST 'http://localhost:9200/static_pages/static_pages/' -d '
{
    "user_name": "Pardeep Saini",
    "user_id": "100000455972792",
    "from": '"\"${area[$i]}\""',
    "from_location": '$from',
    "to": '"\"${area[$j]}\""',
    "to_location": '$to',
    "date_at":'"\"$a\""',
    "have_car":"true",
    "distance_time":"260.181,251"
}'

done

for k in {1..1}
do

curl -XPOST 'http://localhost:9200/static_pages/static_pages/' -d '
{
    "user_name": "Anu Sharma",
    "user_id": "100002283355067",
    "from": '"\"${area[$i]}\""',
    "from_location": '$from',
    "to": '"\"${area[$j]}\""',
    "to_location": '$to',
    "date_at":'"\"$a\""',
    "have_car":"false",
    "distance_time":"258.61,246"
}'
done

 
for k in {1..1}
do

curl -XPOST 'http://localhost:9200/static_pages/static_pages/' -d '
{
    "user_name": "Kamal Preet Kaur",
    "user_id": "100001279621894",
    "from": '"\"${area[$i]}\""',
    "from_location": '$from',
    "to": '"\"${area[$j]}\""',
    "to_location": '$to',
    "date_at":'"\"$a\""',
    "have_car":"true",
    "distance_time":"2687.182,2419"
}'
done


for k in {1..1}
do
curl -XPOST 'http://localhost:9200/static_pages/static_pages/' -d '
{
    "user_name": "Parminder Singh",
    "user_id": "100005735493567",
    "from": '"\"${area[$i]}\""',
    "from_location": '$from',
    "to": '"\"${area[$j]}\""',
    "to_location": '$to',
    "date_at":'"\"$a\""',
    "have_car":"false",
    "distance_time":"257.533,253"
}'
done

for k in {1..1}
do
curl -XPOST 'http://localhost:9200/static_pages/static_pages/' -d '
{
    "user_name": "test user",
    "user_id": "100005714525327",
    "from": '"\"${area[$i]}\""',
    "from_location": '$from',
    "to": '"\"${area[$j]}\""',
    "to_location": '$to',
    "date_at":'"\"$a\""',
    "have_car":"false",
    "distance_time":"257.533,253"
}'
done

fi
done
done
