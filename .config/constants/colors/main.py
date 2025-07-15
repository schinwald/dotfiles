import json
from typing import Any
import re
from wcwidth import wcswidth

ansi_escape = re.compile(r"\x1b\[[0-9;]*[mGK]")


def print_row(row: list[Any], widths: list[int]):
    display = []
    for i, cell in enumerate(row):
        padding = widths[i] - wcswidth(strip_ansi(cell))
        display.append(cell + " " * padding + "  ")
    print("".join(display))


def strip_ansi(s: str):
    return ansi_escape.sub("", s)


def main():
    with open("ansi_colors.json", "r") as fp:
        ansi_colors: list[Any] = json.load(fp)

        # Colorize example column
        for ansi_color in ansi_colors:
            ansi_color["example"] = (
                ansi_color["example"].encode("utf-8").decode("unicode_escape")
            )

        # Define headers
        headers = ["Name", "Example", "Escaped", "Category"]

        # Extract rows as a list
        rows = [
            [values for values in ansi_color.values()] for ansi_color in ansi_colors
        ]

        # Calculate column widths
        columns = list(zip(headers, *rows))
        widths = [
            max([wcswidth(strip_ansi(cell)) for cell in column]) for column in columns
        ]

        # Print header
        print_row(headers, widths)

        # Print body
        for row in rows:
            print_row(row, widths)


if __name__ == "__main__":
    main()
