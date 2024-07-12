#!/bin/bash

set -euo pipefail

REGISTRY_URL="ts.zxcode.xyz:5000"
DEFAULT_TAG="latest"
image_tag=${3:-$DEFAULT_TAG}
DB_FILE="v3-ci.db"
LOG_FILE="/var/log/docker_registry_operations.log"

declare -a registry_images=(
	"postgres"
	"redis"
	"ipfs/kubo"
	"graphprotocol/graph-node"
)

log() {
	echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

error_exit() {
	log "ERROR: $1" >&2
	exit 1
}

docker_pull() {
	log "Pulling image: $1:$2"
	docker pull "$1:$2" >/dev/null 2>&1 || error_exit "Failed to pull image: $1:$2"
}

tag_image() {
	log "Tagging image: $1 as $REGISTRY_URL/$1:$2"
	docker tag "$1:$2" "$REGISTRY_URL/$1:$2" >/dev/null 2>&1 || error_exit "Failed to tag image: $1"
}

docker_push() {
	log "Pushing image: $REGISTRY_URL/$1:$2"
	output=$(docker push "$REGISTRY_URL/$1:$2" 2>&1)
	if echo "$output" | grep -q "Layer already exists"; then
		log "The image had been pushed before."
	else
		log "The image is new to registry."
	fi
}

docker_registry() {
	docker_pull "$1" "$2"
	tag_image "$1" "$2"
	docker_push "$1" "$2"
}

change_dir() {
	target_dir="/v3-instance${1}/v3-ci/"
	cd "$target_dir" || error_exit "Directory not found: $target_dir"
}

change_commit() {
	sqlite3 "$DB_FILE" "UPDATE Projects SET commit_id = 'xxxxxx' WHERE project_name = '${1}';" ||
		error_exit "Failed to update commit ID for project: $1"
	result=$(sqlite3 "$DB_FILE" "SELECT * FROM Projects WHERE project_name = '${1}';") ||
		error_exit "Failed to fetch updated record for project: $1"
	log "$result"

}

_change_commit_in_all() {
	_paths=(
		"1"
		"2"
		"3"
	)
	for path in "${_paths[@]}"; do
		change_dir "${path}"
		readarray -t projects < <(sqlite3 "$DB_FILE" "SELECT project_name FROM Projects;")
		for project in "${projects[@]}"; do
			sqlite3 "$DB_FILE" "UPDATE Projects SET commit_id = 'xxxxxx' WHERE project_name = '${project}';"
			sqlite3 "$DB_FILE" "SELECT * FROM Projects WHERE project_name = '${project}';"
		done
	done

}

case "$1" in
-u)
	[[ -z "$2" ]] && error_exit "No image provided for update."
	[[ -z "$3" ]] && error_exit "No tag provided for update."
	image=$2
	image_found=false
	for registry_image in "${registry_images[@]}"; do
		if [[ "$image" == "$registry_image" ]]; then
			docker_registry "$image" "$image_tag"
			image_found=true
			break
		fi
	done
	$image_found || error_exit "Image $image not found in registry_images array"
	;;
-rb)
	[[ -z "$2" ]] && error_exit "No image provided for rebuild."
	image=$2
	if [ "${image}" == "all" ]; then
		_change_commit_in_all
		exit 0
	fi
	log "In which instance do you want to change?"
	read -r instance
	[[ -z "$instance" ]] && error_exit "No instance provided."
	change_dir "$instance"
	change_commit "$image"
	log "Done in instance $instance"
	;;
-c)
	log "This will clean all registry images in your Docker registry"
	rm -rf /mnt/HC_Volume_33953567/registry/docker/registry/v2 || error_exit "Failed to clean registry"
	log "Registry cleaned"
	;;
*)
	echo "Usage:
 -u <image> (to update and push a specific registry image)
 -rb <image> (to rebuild local images by updating DB)
 -c (to clean registry)"
	;;
esac
