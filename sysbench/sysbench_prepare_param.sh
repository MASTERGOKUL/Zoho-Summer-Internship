# Initialize variables
option="oltp_read_only"
threads=8
host="127.0.0.1"
user="gokul"
password="Password@123"
port=3306
tables=10
table_size=1000000


# Parse command line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --option=*) option="${1#*=}";;
        --threads=*) threads="${1#*=}";;
        --host=*) host="${1#*=}";;
        --user=*) user="${1#*=}";;
        --password=*) password="${1#*=}";;
        --port=*) port="${1#*=}";;
        --tables=*) tables="${1#*=}";;
        --table_size=*) table_size="${1#*=}";;
        *) echo "Unknown parameter passed: $1"; exit 1;;
    esac
    shift
done

option="/usr/share/sysbench/${option}.lua"

sysbench $option --threads=$threads --mysql-host=$host --mysql-user=$user --mysql-password=$password --mysql-port=$port --tables=$tables --table-size=$table_size prepare
