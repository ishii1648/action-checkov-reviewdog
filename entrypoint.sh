#!/bin/bash

[[ ! -z "$INPUT_SKIP_CHECK" ]] && SKIP_CHECK_FLAG="--skip-check $INPUT_SKIP_CHECK"
[[ ! -z "$INPUT_BASELINE" ]] && CHECK_BASELINE="--baseline $INPUT_BASELINE"

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

touch /tmp/output_file
checkov -d $INPUT_WORKING_DIRECTORY $CHECK_BASELINE --download-external-modules $INPUT_DOWNLOAD_EXTERNAL_MODULES --quiet $SKIP_CHECK_FLAG -o json > /tmp/output_file
checkov_return="${PIPESTATUS[0]}"

cat /tmp/output_file \
    | python3 /parse.py \
    | reviewdog -efm="%f:%l: %m" -name="checkov" -reporter="${INPUT_REPORTER}" -fail-on-error="${INPUT_FAIL_ON_ERROR}" -filter-mode="${INPUT_FILTER_MODE}"

reviewdog_return="{PIPESTATUS[2]}" exit_code=$?

checkov_return="${PIPESTATUS[0]}" reviewdog_return="${PIPESTATUS[2]}" exit_code=$?
echo "checkov-return-code=${checkov_return}" >> $GITHUB_OUTPUT
echo "reviewdog-return-code=${reviewdog_return}" >> $GITHUB_OUTPUT

exit $exit_code