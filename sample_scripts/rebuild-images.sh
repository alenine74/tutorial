#!/bin/bash -e

REGISTRY_URL="ts.zxcode.xyz:5000"
TAG="latest"
DB_FILE="v3-ci.db"

declare -a registry_images=(
	"postgres"
	"redis"
	"ipfs/kubo"
	"graphprotocol/graph-node"
)

_docker_pull() {
	docker pull "$1" >/dev/null 2>&1
	if [[ $? -ne 0 ]]; then
		echo "Failed to pull image: $1"
		exit 1
	fi
	echo "Pulled image: $1"
}

_tag_image() {
	docker tag "$1:$TAG" "$REGISTRY_URL/$1:$TAG" >/dev/null 2>&1
	if [[ $? -ne 0 ]]; then
		echo "Failed to tag image: $1"
		exit 1
	fi
	echo "Tagged image: $1 as $REGISTRY_URL/$1:$TAG"
}

_docker_push() {
	_output=$(docker push "$REGISTRY_URL/$1:$TAG" 2>&1)
	if echo "$_output" | grep -q "Layer already exists"; then
		echo "The image had been pushed before. Some layers already existed."
		#i want exit here from this funtion not from the code
	else
		echo "The image is new to registry."
	fi
	if [[ $? -ne 0 ]]; then
		echo "Failed to push image: $1"
		exit 1
	fi
	echo "Pushed $1 to $REGISTRY_URL"
}

_docker_registry() {
	_docker_pull "$1"
	_tag_image "$1"
	_docker_push "$1"
}

_change_dir() {
	target_dir="/v3-instance${1}/v3-ci/"
	cd "$target_dir" || {
		echo "Directory not found: $target_dir"
		exit 1
	}
}

_change_commit() {
	command="UPDATE Projects SET commit_id = 'xxxxxx' WHERE project_name = '${1}';"
	sqlite3 "$DB_FILE" "$command" >/dev/null 2>&1
	if [[ $? -ne 0 ]]; then
		echo "Failed to update commit ID for project: $1"
		exit 1
	fi
	result=$(sqlite3 "$DB_FILE" "SELECT * FROM Projects WHERE project_name = '${1}';")
	if [[ $? -ne 0 ]]; then
		echo "Failed to fetch updated record for project: $1"
		exit 1
	fi
	echo "$result"
}

case "$1" in
-u)
	if [[ -z "$2" ]]; then
		echo "Error: No image provided for update."
		exit 1
	fi
	image=${2}
	for registry_image in "${registry_images[@]}"; do
		if [ "$image" == "$registry_image" ]; then
			_docker_registry "$image"
			break
		fi
	done
	;;
-rb)
	if [[ -z "$2" ]]; then
		echo "Error: No image provided for rebuild."
		exit 1
	fi
	image=${2}
	echo "In which instance do you want to change?"
	read -r instance
	if [[ -z "$instance" ]]; then
		echo "Error: No instance provided."
		exit 1
	fi
	_change_dir "$instance"
	_change_commit "$image"
	echo "Done in instance $instance"
	;;
-a)
	for image in "${registry_images[@]}"; do
		_docker_registry "$image"
	done
	;;
-c)
	echo "This will clean all registry images in your Docker registry"
	rm -rf /mnt/HC_Volume_33953567/registry/docker/registry/v2/repositories/* || {
		echo "Failed to clean registry"
		exit 1
	}
	echo "Registry cleaned"
	;;
*)
	echo -e "Usage: \n -u <image> (to update and push a specific registry image) \n -rb <image> (to rebuild local images by updating DB) \n -a (to update and push all registry images) \n -c (to clean registry)"
	;;
esac
