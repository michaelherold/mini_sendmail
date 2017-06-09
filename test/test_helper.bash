SCRIPT=$(realpath "$BATS_TEST_FILENAME")
SCRIPTPATH=$(dirname "$SCRIPT")
SENDMAIL=$(realpath "${SCRIPTPATH}"/../mini_sendmail)

flunk() {
	if [ "$#" -eq 0 ]; then cat -
	else echo "$@"
	fi

	return 1
}


assert_equal() {
	if [ "$1" != "$2" ]; then
		{
			echo "expected: $1"
			echo "actual: $2"
		} | flunk
	fi
}

run_example() {
	local recipient="$1"
	local result

	result=$(echo "Subject: Test" | ${SENDMAIL} -v "${recipient}" 2>&1)

	echo "${result}"
}
