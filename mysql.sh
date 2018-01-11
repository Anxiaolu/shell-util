#########################################################################
# File Name: mysql.sh
# Author: Anxiaolu
# mail: 17864306583@163.com
# Created Time: 2018年01月11日 星期四 08时59分14秒
#########################################################################
#!/bin/bash

HOSTNAME="127.0.0.1"    #数据库信息
PORT="3306"
USERNAME="root"
PASSWORD="314"

DBNAME1="phpcms"         #数据库名称
DBNAME2="phpcms_new"
TABLENAME="v9_admin"


MYSQL="mysql -h${HOSTNAME}  -P${PORT}  -u${USERNAME} -p${PASSWORD} --default-character-set=utf8 -A -N"
sql="select * from $DBNAME1.$TABLENAME"
#declare COMMAND0='mysql -h localhost -uroot -p314 -e "${sql}"'
get_tables_sql="use $DBNAME1;show tables"

tables_array="$($MYSQL -e "$get_tables_sql")"
#prime_key="$($MYSQL -e "select column_name from INFORMATION_SCHEMA.KEY_COLUMN_USAGE where table_schema = 'phpcms'")"	


OLD_IFS="$IFS" 
IFS=" "
IFS="$OLD_IFS" 
table_arr=($tables_array) 
#prime_arr=($prime_key)

for (( i = 0; i < ${#table_arr[@]}; i++ )); do
	#echo ${table_arr[$i]}

	prime_key="$($MYSQL -e "select column_name from INFORMATION_SCHEMA.KEY_COLUMN_USAGE where table_schema = '$DBNAME1' and table_name = '${table_arr[$i]}'")"
	OLD_IFS="$IFS" 
	IFS=" "
	IFS="$OLD_IFS" 

	#echo ${#prime_key[@]}

	prime_arr=($prime_key)
	#echo ${prime_arr[$i]}
	if [[ $prime_key ]]; then
		#echo ${#prime_arr[@]} ${prime_arr[0]}  ${prime_arr[1]}
		if [[ ${#prime_arr[@]}=1 ]]
		 then
			echo ${prime_arr}
			#for (( j = 0; j < ${#prime_arr[@]}; j++ )); do
			#	echo ${prime_arr[$j]} ++++++++++++${table_arr[$i]}
			#	echo "${$MYSQL -e 'select * from $DBNAME1.${table_arr[$i]} a where not exists (select * from $DBNAME2.${table_arr[$i]} b where a.${prime_arr[$j]} = b.${prime_arr[$j]})' > ./test/${table_arr[$i]}.sql}"
			#done
			echo "$($MYSQL -e "select * from $DBNAME1.${table_arr[$i]} a where not exists (select * from $DBNAME2.${table_arr[$i]} b where a.${prime_arr} = b.${prime_arr})" > ./test/${table_arr[$i]}.excel)"

		else [[ ${#prime_arr[@]}=2 ]]
			#echo $prime_arr[$j]
			echo "$MYSQL -e "select * from $DBNAME1.${table_arr[$i]} a where not exists (select * from $DBNAME2.${table_arr[$i]} b where a.${prime_arr[0]} = b.${prime_arr[1]}""
			echo "$($MYSQL -e "select * from $DBNAME1.${table_arr[$i]} a where not exists (select * from $DBNAME2.${table_arr[$i]} b where a.${prime_arr[0]} = b.${prime_arr[1]}" > ./test/${table_arr[$i]}.excel)"
		fi
	fi

	#echo di $i ge   ${prime_arr[$i]}      ${table_arr[$i]};
	#echo "$($MYSQL -e "select * from $DBNAME1.${table_arr[$i]} a where not exists (select * from $DBNAME2.${table_arr[$i]} b where a.${prime_arr[$i]} = b.${prime_arr[$i]})" > ./test/${table_arr[$i]}.excel)"
done





# for p in ${prime_arr[@]}, t in ${table_arr[@]}
# do 
# 	echo $t
# 	#echo "$($MYSQL -e "use phpcms;show tables")"
#     #echo "$($MYSQL -e "use phpcms;desc $s")" 
#     #echo "$($MYSQL -e "select * from $DBNAME1.$t a where not exists (select * from $DBNAME2.$t b where a.$p = b.$p)" > ./test/$t.	sql)"
# done
# for item in $tables_array
# do
# 	echo "the item is $item"	
# done

#echo ${#arr[@]}

# for (( i = 0; i < $tables_array[@]; i++ )); do
# 	#statements
# done