#!/bin/sh

[ -n "$TEMP_IMAGE" ] || TEMP_IMAGE="gmitirol/resquewebui"

docker build --file Dockerfile --tag $TEMP_IMAGE .
