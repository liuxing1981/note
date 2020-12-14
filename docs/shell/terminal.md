# Terminal short key



* ctrl+a: 开始位置
* ctrl+e: 最后位置
* ctrl+k: 删除此处至末尾所有内容
* ctrl+u: 删除此处至开始所有内容
* ctrl+d: 删除当前字母
* ctrl+w: 删除此处到左边的单词
* ctrl+y: 粘贴由ctrl+u，ctrl+d，ctrl+w删除的单词
* ctrl+r: 搜索命令
* ctrl+l: 相当于clear
* ctrl+b: 向回移动
* ctrl+f: 向前移动
* ctrl+p: 向上显示缓存命令
* ctrl+n: 向下显示缓存命令
* ctrl+d: 关闭终端
* shift+上或下: 终端上下滚动
* shift+pgup或pgdown: 终端上下翻页滚
* ctrl+shift+f: 全屏（仅限于konsole）
* ctrl+shift+n: 新终端（terminal和konsole有所不同）
* ctrl+c: 终止



#### Bang（感叹号）

- !! —— 执行上一条命令
- !blah —— 执行最近运行过的以blah开头的命令
- !blah:p —— 打印!blah要执行的命令（并将其作为最后一条命令加入到命令历史中）
- !$ —— 上一条命令的最后一个单词 (等同于Alt + .
- !$:p —— 打印!$指代的单词
- !* —— 上一条命令除最后一个词的部分
- !:p —— 打印!指代部分