import json, sys
from os import isatty

def main():

    data = json.load(sys.stdin)
    if isinstance(data, list) and 'failed_checks' in data[0]["results"]:
        failed_checks = data[0]["results"].get("failed_checks")
    elif isinstance(data, dict):
        if 'results' in data:
            failed_checks = data["results"].get("failed_checks")
        else:
            exit(0)
    if failed_checks is None:
        exit(0)

    for failed_check in failed_checks:
        check_id = failed_check["check_id"]
        file_name = failed_check["file_path"]
        line_number = failed_check["file_line_range"][0]
        error_message = failed_check["check_name"]
        print('{}:{}: [{}] {}'.format(file_name, line_number, check_id, error_message))

    exit(1)

if __name__ == "__main__":
    main()