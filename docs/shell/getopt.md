# getopt 比较复杂，支持长命令

```
ARGS=`getopt -o c::a:f:lh --long config::,aps:,file:,latest,help -n 'a.sh' -- "$@"`
eval set -- "${ARGS}"
echo $ARGS
while true
do
    case "$1" in
        -c|--config)
            case "$2" in
            "")
                echo "The config file is not set. Use default config.yaml"
                config=config.yaml
                log=$log
                shift 2;;
            *)
                echo "use config file: $2"
                config=$2
                shift 2;;
            esac;;
        -a|--aps)
            file_name=$2
            echo "$file_name" | grep -Ew "[0-9]+" && file_name=IMSDL${file_name}.NOST.tar.gz
            if [[ ! "$file_name" =~ ".tar.gz" ]];then
                file_name=${file_name}.tar.gz
            fi
            get_package "$path/$file_name"
            shift 2;;
        -f|--file)
            get_package $2
            shift 2;;
        -l|--latest)
            get_package "latest"
            shift;;
        -h|--help)
            usage
            shift;;
        --)
            shift
            break;;
    esac
done
```

#### c:: 可以加参数，也可以不加
```
# c:: 必须这样写参数
-cconfig.yaml
--config=config.yaml
```
#### a: 必须加参数
#### h  不加参数