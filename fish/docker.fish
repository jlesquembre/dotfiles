function denter --description 'Enter in a docker container'
    switch (count $argv)
        case 1
            set pid (docker inspect --format '{{.State.Pid}}' $argv)
            set pstatus $status
            if test $pstatus -ne 0
                return $pstatus
            end
            sudo nsenter --target $pid --mount --uts --ipc --net --pid
        case '*'
            echo 'Provice ONE container id or name'
    end
end

function dockrm_untag  --description 'Remove docker untagged images'
    set image_ids (docker images -q --filter "dangling=true")
    if [ -n "$image_ids" ]
        docker rmi $image_ids
    end
end

function dockrm_containers  --description 'Remove docker stopped containers'
    docker rm (docker ps -aq)
end
