# Initialize variables
name=""

# Parse command line options
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --name=*) name="${1#*=}";;
        *) echo "Unknown parameter passed: $1"; exit 1;;
    esac
    shift
done

echo $name
