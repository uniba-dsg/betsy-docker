function open() {
	declare html=$1

	if [[ -f $html ]]; then
		start $html
	fi
}

function extractLogs() {
	declare container=$1 folder=$2

	mkdir --parents $folder
	docker cp "$container:/opt/betsy/test" "$folder"
	docker cp "$container:/opt/betsy/betsy.log" "$folder"
	docker cp "$container:/opt/betsy/betsy_time.log" "$folder"
	docker cp "$container:/opt/betsy/betsy_console.log" "$folder"
}