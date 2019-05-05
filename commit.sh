#!/bin/bash

DOCS=docs
CONTENTS=
for f in `find $DOCS -name "*" | sort`;do
    LINE=
    SPACE=
#    [ "$f" = "$DOCS" ] && continue

    #print space
    count=$(echo $f | grep -o "/" | wc -l)
    for((i=0;i<$count-1;i++));do
       SPACE="$SPACE  "
    done
    file=${f##*/}
    #if file is a md file 
    if [[ "$file" =~ ".md" ]];then 
        file=`echo $file | sed 's/\.md//'`
        [ "$file" = "readme" -o "$file" = "README" ] && continue
    elif [ -d $DOC/$file ];then
        result=`find $f -iname readme.md | wc -l`
        if [ "$result" -eq "0"  ];then
           dir=`echo $f | awk -F/ '{print $NF}'`
           touch $f/README.md
           echo -n "# The note for $dir"> $f/README.md
        fi
        f="$f/README.md"
    fi
    LINE="${SPACE}* [${file}](${f})"
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
