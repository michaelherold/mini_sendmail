#!/usr/bin/env bats

load test_helper

test_recipient() {
	local recipient=$1
	local result

	result=$(run_example "${recipient}" | grep "RCPT" | sed 's/>>>> RCPT TO://')
	echo "${result}"
}

@test "handles a terribly mangled RFC5322 To:" {
	result=$(test_recipient '\"\\\"michael.herold@getflywheel.com\\\"\" <michael.herold@getflywheel.com>')

	assert_equal "<michael.herold@getflywheel.com>" "$result"
}

@test "handles a bare email address" {
	result=$(test_recipient 'michael.herold@getflywheel.com')

	assert_equal "<michael.herold@getflywheel.com>" "$result"
}

@test "handles an angle-addr" {
	result=$(test_recipient '<michael.herold@getflywheel.com>')

	assert_equal "<michael.herold@getflywheel.com>" "$result"
}
