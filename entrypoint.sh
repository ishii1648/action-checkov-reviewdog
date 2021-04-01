#!/bin/bash

[[ ! -z "$INPUT_SKIP_CHECK" ]] && SKIP_CHECK_FLAG="--skip-check $INPUT_SKIP_CHECK"

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

# TEMP_PATH="$(mktemp -d)"
# PATH="${TEMP_PATH}:$PATH"

# echo '::group::🐶 Installing reviewdog ... https://github.com/reviewdog/reviewdog'
# curl -sfL https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b "${TEMP_PATH}" "${REVIEWDOG_VERSION}" 2>&1
# echo '::endgroup::'

checkov -d $INPUT_WORKING_DIRECTORY $SKIP_CHECK_FLAG -o json \
    | python3 /parse.py \
    | reviewdog -efm="%f:%l: %m" -name="checkov" -reporter="${INPUT_REPORTER}" -fail-on-error="${INPUT_FAIL_ON_ERROR}" -filter-mode="${INPUT_FILTER_MODE}"

exit_code=$?
echo $exit_code

exit $exit_code