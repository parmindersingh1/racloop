#!/bin/bash
#Enter current lacations's latitude and longitude 

lat=30.7353
long=76.7911

#Enter Future time to display in people near or past time to display in history

dt="2013-04-30"
tm="04:30:00"

dtm=\"$dt"T"$tm\"

  c=$lat
  d=$long


echo $c
for i in {1..2}
do
c=$(echo "$c + 0.02" | bc -l)
d=$(echo "$d + 0.02" | bc -l)
e="\"$c,$d\""
echo $c
curl -XPOST 'http://localhost:9200/static_pages/static_pages/' -d '
{
    "user_name": "Rajan Punchouty",
    "user_id": "100005196784043",
    "from": "Panchkula, Haryana, India" ,
    "from_location": '$e',
    "to":"Delhi, India",
    "to_location":"28.635308, 77.22496000000001",
    "date_at":'$dtm',
    "have_car":"false",
    "distance_time":"255.109,245"
}'

done

 c=$lat
 d=$long

for i in {1..2}
do
c=$(echo "$c - 0.02" | bc -l)
d=$(echo "$d - 0.02" | bc -l)
e="\"$c,$d\""

curl -XPOST 'http://localhost:9200/static_pages/static_pages/' -d '
{
    "user_name": "Pardeep Saini",
    "user_id": "100000455972792",
    "from": "Mohali, Punjab, India" ,
    "from_location": '$e',
    "to":"Delhi, India",
    "to_location":"28.635308, 77.22496000000001",
    "date_at":'$dtm',
    "have_car":"true",
    "distance_time":"260.181,251"
}'

done

 c=$lat
 d=$long

for i in {1..2}
do
c=$(echo "$c + 0.008" | bc -l)
d=$(echo "$d - 0.003" | bc -l)
e="\"$c,$d\""
curl -XPOST 'http://localhost:9200/static_pages/static_pages/' -d '
{
    "user_name": "Anu Sharma",
    "user_id": "100002283355067",
    "from": "Sector 22, Chandigarh, India" ,
    "from_location": '$e',
    "to":"Akshardham, Noida Link Road, Ganesh Nagar, Patparganj, Delhi, India",
    "to_location":"28.617988, 77.27937199999997",
    "date_at":'$dtm',
    "have_car":"false",
    "distance_time":"258.61,246"
}'
done


 c=$lat
 d=$long

for i in {1..2}
do
c=$(echo "$c - 0.011" | bc -l)
d=$(echo "$d - 0.001" | bc -l)
e="\"$c,$d\""
curl -XPOST 'http://localhost:9200/static_pages/static_pages/' -d '
{
    "user_name": "Kamal Preet Kaur",
    "user_id": "100001279621894",
    "from": "Sector 17, Chandigarh, India" ,
    "from_location": '$e',
    "to":"Tamil Nadu, India",
    "to_location":"11.1271225, 78.65689420000001",
    "date_at":'$dtm',
    "have_car":"true",
    "distance_time":"2687.182,2419"
}'
done

 c=$lat
 d=$long

for i in {1..2}
do
c=$(echo "$c - 0.02" | bc -l)
d=$(echo "$d + 0.005" | bc -l)
e="\"$c,$d\""
curl -XPOST 'http://localhost:9200/static_pages/static_pages/' -d '
{
    "user_name": "Parminder Singh",
    "user_id": "100005735493567",
    "from": "Sector 26, Chandigarh, India" ,
    "from_location": '$e',
    "to":"Delhi Cantonment, New Delhi, Delhi, India",
    "to_location":"28.586738, 77.13199889999999",
    "date_at":'$dtm',
    "have_car":"false",
    "distance_time":"257.533,253"
}'
done


