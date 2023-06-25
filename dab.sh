
DAB_IMAGE="image"

commit() {
    cname=$(git log -1 --pretty=format:%h)
    echo "c-${cname}"
}

branch() {
    bname=$(git branch --show-current)
    echo "b-${bname}"
}