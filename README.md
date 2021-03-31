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
