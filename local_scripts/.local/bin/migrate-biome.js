#!/usr/bin/env python

import os
import json
import sys


BIOME_PACKAGES = ["@biomejs/biome"]


def is_npm_project():
    return os.path.exists("package-lock.json")


def is_yarn_project():
    return os.path.exists("yarn.lock")


def is_none_biome_lint_and_format_package(package_name):
    if "eslint" in package_name or "prettier" in package_name.lower():
        return True
    if package_name == "standard":
        return True
    if package_name == "gts":
        return True
    return False


def get_none_biome_lint_and_format_packages():
    with open("package.json") as f:
        package_json = json.load(f)
        dev_dependencies = package_json.get("devDependencies", {}).keys()
        dev_none_biome_lint_and_format_packages = filter(
            is_none_biome_lint_and_format_package, dev_dependencies
        )
        # if contains eslint or prettier, add to the set
    # return dev_none_biome_lint_and_format_packages
    # unpack to list
    return list(dev_none_biome_lint_and_format_packages)


true = True

DEFAULT_BIOME_JSON = {
    "$schema": "https://biomejs.dev/schemas/1.5.3/schema.json",
    "organizeImports": {"enabled": true},
    "linter": {
        "enabled": true,
        "rules": {"recommended": true, "suspicious": {"noExplicitAny": "off"}},
    },
    "formatter": {"enabled": true, "indentStyle": "space"},
    "javascript": {"formatter": {"quoteStyle": "single"}},
    "files": {"ignore": ["node_modules", "dist", "coverage"]},
}


def update_package_json_scripts():
    with open("package.json") as f:
        data = json.load(f)
        scripts = data.get("scripts", {})
        scripts["format"] = "biome format . --write"
        scripts["lint"] = "biome lint ."
        scripts["fix"] = "biome lint . --apply"
        scripts["fix-unsafe"] = "biome lint . --apply-unsafe"
        data["scripts"] = scripts
    with open("package.json", "w") as f:
        json.dump(data, f, indent=2)


def main():
    is_npm = is_npm_project()
    is_yarn = is_yarn_project()
    if not is_npm and not is_yarn:
        print("Not a npm or yarn project")
        sys.exit(1)
    eslint_and_prettier_packages = get_none_biome_lint_and_format_packages()
    print(f"Found eslint and prettier packages: {eslint_and_prettier_packages}")
    if is_npm:
        # remove all the eslint and prettier packages
        os.system(f"npm uninstall {' '.join(eslint_and_prettier_packages)}")
        # install the biome package
    elif is_yarn:
        # remove all the eslint and prettier packages
        os.system(f"yarn remove {' '.join(eslint_and_prettier_packages)}")
        # install the biome package
    if is_npm:
        os.system(f"npm install {' '.join(BIOME_PACKAGES)} --save-dev")
    if is_yarn:
        os.system(f"yarn add {' '.join(BIOME_PACKAGES)} --dev")
    # remove any .eslint*, .prettier*
    os.system("rm -f .eslint* .prettier*")
    # reopen the package.json and add the biome script
    # format, lint, fix, fix-unsafe
    update_package_json_scripts()
    # open the biome.json file and write the default configuratig
    with open("biome.json", "w") as f:
        json.dump(DEFAULT_BIOME_JSON, f, indent=2)


if __name__ == "__main__":
    main()
