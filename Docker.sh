docker run -it 	--rm --privileged=true \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix$DISPLAY \
    -v $(pwd):/home/developer/ \
    -v /dev/snd:/dev/snd \
    jack_mixer:latest
