#!/bin/bash

# declare array yang tipe associative
declare -A user error_msg user_error user_info

syslog=./syslog.log
jenis_log=(ERROR INFO)

# regex sekaligus terdapat perintah yang digunakan dalam program sed
# untuk mereplace string, yakni s/(regex)/(pengganti)
regex_pesan='s/[^:]*:[^:]*:[^:]*: \([^ ]*\) \([^[#]*\) [^\(]*(\([^)]*\).*/\2/'
regex_user='s/[^:]*:[^:]*:[^:]*: \([^ ]* \)\([^[#]*\) [^\(]*(\([^)]*\).*/\3/'

# mendapatkan seluruh user yang tercatat di syslog.log
get_user="$(sed "$regex_user" $syslog | sed 's/\(.*\)/user["\1"]=0;/')"
eval $get_user

# count pesan error per pesan
get_error_msg=$(/bin/grep ERROR $syslog | sed "$regex_pesan" $syslog | sed 's/\(.*\)/error_msg["\1"]=$((${error_msg["\1"]}+1));/')
eval $get_error_msg

# mendapatkan count info dan error per user
for u in "${!user[@]}"
do
    # count error
    user_error[$u]=$(/bin/grep -E "ERROR.*$u" $syslog | wc -l)

    # count info
    user_info[$u]=$(/bin/grep -E "INFO.*$u" $syslog | wc -l)
done

# looping nulis format csv
for msg in "${!error_msg[@]}"
do
    error_message_csv="$error_message_csv\n$msg,${error_msg[$msg]}"
done

# masukkan ke file csv
error_message_csv=$(printf "$error_message_csv" | sort -k2 -n -t, -r)
printf "Error,Count\n$error_message_csv" >./error_message.csv

# looping nulis format csv
for u in "${!user[@]}"
do
    user_statistic_csv="$user_statistic_csv\n$u,${user_info[$u]},${user_error[$u]}"
done

# masukkan ke file csv
user_statistic_csv=$(printf "$user_statistic_csv" | sort -k1 -t,)
printf "Username,INFO,ERROR$user_statistic_csv" >./user_statistic.csv