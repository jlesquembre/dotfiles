
PID=$(docker inspect --format '{{.State.Pid}}' <container>)

# launch a shell
sudo nsenter --target $PID --mount --uts --ipc --net --pid

# run command
sudo nsenter --target $PID --mount --uts --ipc --net --pid <command>

# remove untagged images
image_ids=$(docker images -q --filter "dangling=true")
if [ -n "$IMAGE_IDS" ]; then
  docker rmi $IMAGE_IDS > /dev/null 2>&1
fi
