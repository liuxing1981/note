## Session
```
#启动一个server
tmux new -t session-name
tmux kill-server

#进入
tmux a -t session-name

#list
tmux ls

#kill
/usr/bin/tmux kill-session -t session-name

# 屏幕自适应
tmux a -d
```

## Window ctrl + b 
* c new window
* , rename window
* & close window
* n next window
* p previous window
* $ rename session name

## pane ctrl + b 
* " h-split window
* % v-split window
* o next pane
* z min,max pane
* x close current pane

## show all prefix keys
```
tmux show-options -g | grep prefix
```

## tmux conf
```
tmux source-file .tmux.conf
```

## tmux config file
```
[.tmux.conf](https://github.com/liuxing1981/tools/blob/master/tmux/tmux.conf)
cp .tmux.conf ~/
```

