import os
import re
from random import choices

import in_place


def load_file():
    lines = list[str]()
    with open(os.getenv("DWT_TAGLINEFILE", "r")) as f:
        line_re = re.compile("\s+\*\s+(.+)")
        for line in f:
            m = line_re.match(line)
            if m:
                lines.append(m.group(1))
    return lines


def update_config(items: list[str]):
    php_prop = "$conf['plugin']['tplmod']['taglines']"
    config_file = os.getenv("DWT_CONFIGFILE")
    with in_place.InPlace(config_file, backup_ext=".bak") as f:
        for line in f:
            if php_prop in line:
                f.write(f"${php_prop} = '${items}';\n")
            else:
                f.write(line)


def main():
    lines = load_file()
    if len(lines) > 6:
        items = ",".join(
            [x.replace(",", "﹐").replace("'", "").strip() for x in choices(lines, k=7)]
        )
        print(items)
        update_config(items)


if __name__ == "__main__":
    main()
