# GitHub Action: Run checkov with reviewdog

## Inputs

**Required**. Must be in form of `github_token: ${{ secrets.github_token }}`.

### `reporter`

Optional. Reporter of reviewdog command [`github-pr-check`,`github-pr-review`].
The default is `github-pr-check`.

### `filter_mode`

Optional. Filtering for the reviewdog command [`added`,`diff_context`,`file`,`nofilter`].

The default is `added`.

See [reviewdog documentation for filter mode](https://github.com/reviewdog/reviewdog/tree/master#filter-mode) for details.

### `fail_on_error`

Optional. Exit code for reviewdog when errors are found [`true`,`false`].

The default is `false`.

See [reviewdog documentation for exit codes](https://github.com/reviewdog/reviewdog/tree/master#exit-codes) for details.

### `working_directory`

Optional. Directory to run the action on, from the repo root.
The default is `.` ( root of the repository).

## Example usage

```yml
name: checkov-reviewdog
on: [pull_request]
jobs:
  checkov-reviewdog:
    name: runner / checkov-reviewdog
    runs-on: ubuntu-latest

    steps:
      - name: Clone repo
        uses: actions/checkout@master

      # Minimal example
      - name: checkov-reviewdog
        uses: ishii1648/action-checkov-reviewdog@master
        with:
          github_token: ${{ secrets.github_token }}

      # More complex example
      - name: checkov-reviewdog
        uses: ishii1648/action-checkov-reviewdog@master
        with:
          github_token: ${{ secrets.github_token }}
          reporter: github-pr-review # Optional. Change reporter
          fail_on_error: "true" # Optional. Fail action if errors are found
          filter_mode: "nofilter" # Optional. Check all files, not just the diff
          skip_check: "CKV_GCP_13" # Optional. Skip Check CKV
          working_directory: "testdata" # Optional. Change working directory
```
