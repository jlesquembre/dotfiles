function denter --description 'Enter in a docker container'
    docker exec -it $argv bash
end

function dockrm_untag  --description 'Remove docker untagged images'
    set image_ids (docker images -q --filter "dangling=true")
    if [ -n "$image_ids" ]
        docker rmi $image_ids
    end
end

function dockrm_images  --description 'Remove ALL docker images'
    set image_ids (docker images -q)
    if [ -n "$image_ids" ]
        docker rmi $image_ids
    end
end

function dockrm_containers  --description 'Remove docker stopped containers'
    docker rm -v (docker ps -aq)
end
