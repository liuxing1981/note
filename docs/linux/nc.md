
## Send shell command
```
 # host A
 nc -lp 5555 -e /bin/bash

 # host B
 nc ip 5555
```

## Communicate two hosts
```
# host A
nc -lp port

# host B
nc -nv ip port
```

## Scan port
```
nc -nvz ip 1-65535
```

## Send file
```
# host A recevie file
nc -lp 4444 >1.txt

# host B send file
nc -nv ip port <1.txt -q 1
```

## media stream
```
A host A
cat wing.mp4|nc -lp port

# host B play with mplayer
nc -nv ip port |mplayer -vo x11 -cache 4000
```