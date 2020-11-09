#!/bin/bash

export docker_us_host="jgwill/us"

cfile=$1
inbasename=$(basename $1)
# inbasename=${iname%.*}
# cfile=$1
# inbasename2=${cfile%.*}
# echo $inbasename2
# echo $iname
# exit


# mount the ./images and run the test from the container
# python demo.py --input images/101027.jpg

echo docker run --rm -v $(pwd)/images:/us/input  $docker_us_host  "input/$inbasename"

echo tmp running it as Interactive with mounted dir
docker run -it --rm  -e DISPLAY -e XAUTHORITY=/tmp/.Xauthority -v /root/.Xauthority:/tmp/.Xauthority -v /tmp/.X11-unix:/tmp/.X11-unix  -v $(pwd)/images:/us/input  $docker_us_host  bash 
#docker run -it --rm -v/tmp/.X11-unix -e DISPLAY=:0  -v $(pwd)/images:/us/input  $docker_us_host  bash 
#-e DISPLAY=unix$DISPLAY
#"input/$inbasename"
#exit

# From /x/x__style_transfer_darkat__2010251156
#docker run --rm -v $source_dir_name:/ne/input  $docker_ne_host --zoom=$zoomFactor "input/$inbasename"
