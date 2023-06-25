#!/bin/bash

DAB_IMAGE="image"
DEFAULT_BRANCH="main"

commit() {
    cname=$(git log -1 --pretty=format:%h)
    echo "${cname} 0"
}

branch() {
    bname=$(git branch --show-current)
    echo "${bname} 1"
}

tag() {
    tname=`git name-rev --name-only --tags HEAD | sed 's/^undefined$//'`
    echo "${tname} 0"
}

target_image_exists() {
    image="${1}"
    docker manifest inspect "${image}" > /dev/null
}

check_registry_access() {
    image="${1}"
    echo "👷 Checking if we can login to registry for '${image}'"
    docker manifest inspect "${image}" 2>&1 | grep "unauthorized > /dev/null"
    ret_val=$?
    if [ $? ]; then 
        echo "❌ Can't login to registry for ${image}"
        exit 1
    else
        echo "✅ Login OK"
    fi
}
    


main() {
    dab_options=("commit" "branch" "tag")
    for option in "${dab_options[@]}"
    do 
        dab_option_return=$(${option})
        dab_val=$(echo "$dab_option_return" | head -n1 | cut -d " " -f1)
        dab_mutable=$(echo "$dab_option_return" | head -n1 | cut -d " " -f2)
        if [ -z "${dab_val}" ]; then
            echo "❌ ${option}"
        else
            target_image="${DAB_IMAGE}:${option:0:2}-${dab_val}"
            target_image_exists $target_image
            it_exists=$?
            if [ it_exists ] && [ dab_mutable ]; then
                echo "✅ ${option} ${target_image} OK_TO_PUSH"
            elif [ it_exists ] && [ ! dab_mutable ]; then
                echo "❌ ${option} ${target_image} KO_TO_PUSH"
            else 
                echo "✅ ${option} ${target_image} OK_TO_PUSH"
            fi 
        fi
    done
}

check_registry_access $DAB_IMAGE
main
