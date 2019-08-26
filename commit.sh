#!/bin/bash

DOCS=docs
CONTENTS=
for f in `find $DOCS -name "*" | sort`;do
    LINE=
    SPACE=
    [ "$f" = "$DOCS" ] && continue

    #print space
    count=$(echo $f | grep -o "/" | wc -l)
    for((i=0;i<$count-1;i++));do
       SPACE="$SPACE  "
    done
    file=$(basename $f)
    readme=$f
    #if file is a md file 
    if [ "$file" == "readme.md" -o "$file" == "README.md" ];then
        continue 
    elif [ -d $f ];then
        result=`find $f -iname readme.md | wc -l`
        if [ "$result" -eq "0"  ];then
            dir=$(dirname $f)
            touch $f/README.md
            echo -n "# The note for $dir"> $f/README.md
            readme="$f/README.md"
        elif [ "$result" -eq "1"  ];then
            readme=$(find $f -iname readme.md)
        fi
    fi
	file=${file%.*}
    LINE="${SPACE}* [${file}](${readme})"
    CONTENTS="$CONTENTS$LINE\n"
done
echo -e "$CONTENTS" > SUMMARY.md
cat SUMMARY.md
echo "recreate summary successed!"
if [ "$1" ];then
    git add -A && git commit -m "$1" && git pull --rebase && git push
else 
    echo "please input commit message for git commit"
    exit 1
fi
