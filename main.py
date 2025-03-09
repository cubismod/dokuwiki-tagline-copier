import os
import re
from random import choices


def load_file():
    lines = list[str]()
    with open(os.getenv("DWT_TAGLINEFILE", "r")) as f:
        line_re = re.compile("\s+\*\s+(.+)\s*")
        for line in f:
            m = line_re.match(line)
            if m:
                lines.append(m.group(1))
    return lines


def main():
    lines = load_file()
    if len(lines) > 6:
        items = ",".join(
            [x.replace(",", ";").replace("'", "").strip() for x in choices(lines, k=7)]
        )
        print(items)


if __name__ == "__main__":
    main()
