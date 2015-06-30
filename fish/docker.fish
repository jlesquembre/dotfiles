function denter --description 'Enter in a docker container'
    docker exec -it $argv sh
end

function dockrm_untag  --description 'Remove docker untagged images'
    set image_ids (docker images -q --filter "dangling=true")
    if [ -n "$image_ids" ]
        docker rmi $image_ids
    else
        echo "No untagged docker images, nothing to do"
    end
end

function dockrm_images  --description 'Remove ALL docker images'
    set image_ids (docker images -q)
    if [ -n "$image_ids" ]
        docker rmi $image_ids
    else
        echo "No docker images, nothing to do"
    end
end

function dockrm_containers  --description 'Remove docker exited containers'
    set cont_ids (docker ps -aq -f "status=exited")
    if count $cont_ids > /dev/null
        docker rm -v $cont_ids
    else
        echo "No exited docker containers, nothing to do"
    end
end
