#!/usr/bin/env python3

import sys
import yaml
import os


def get_value_from_yaml(file_path, key):
    # Check if file exists
    if not os.path.exists(file_path):
        return ""

    try:
        # read and parse YAML file
        with open(file_path, "r") as file:
            data = yaml.safe_load(file)

        # split the key path
        keys = key.split(".")

        # first try with the specified element if it's not 'default'
        if keys[0] != "default":
            # try to find in the specified element
            current = data
            for k in keys:
                if isinstance(current, dict) and k in current:
                    current = current[k]
                else:
                    # key not found, try with 'default' path
                    break
            else:
                # if we didn't break out of the loop, we found the value
                return str(current)

            # try with 'default' path
            fallback_keys = ["default"] + keys[1:] if len(keys) > 1 else ["default"]
            current = data
            for k in fallback_keys:
                if isinstance(current, dict) and k in current:
                    current = current[k]
                else:
                    # key not found in default path either
                    return ""
            return str(current)
        else:
            # navigate through the nested structure starting with 'default'
            current = data
            for k in keys:
                if isinstance(current, dict) and k in current:
                    current = current[k]
                else:
                    return ""
            return str(current)

    except yaml.YAMLError:
        return ""
    except Exception:
        return ""


def main():
    # check if correct number of arguments are provided
    if len(sys.argv) != 3:
        sys.exit(1)

    yaml_file = sys.argv[1]
    key = sys.argv[2]

    # get and print the value
    value = get_value_from_yaml(yaml_file, key)
    print(value, end="")  # Print without newline


if __name__ == "__main__":
    main()
