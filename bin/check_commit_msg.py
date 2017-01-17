#!/usr/bin/env python3
"""
Checks the commit log message.

Called by "git commit" with one argument, the name of the file
that has the commit message.  The hook should exit with non-zero
status after issuing an appropriate message if it wants to stop the
commit.  The hook is allowed to edit the commit message file.
"""

import sys
from typing import List

def check_body(body_lines: List[str]) -> bool:
    """
    Checks the message body.
    """
    valid = True

    for line_nb, line in enumerate(body_lines, start=3):
        line_length = len(line)
        if(line_length > 72):
            print("[ERR] Line {} is too long ({})".format(line_nb, line_length))
            valid &= False
    
    return valid


def check_summary(summary: str) -> bool:
    """
    Checks the summary line.
    """
    if(len(summary) > 50):
        print("[ERR] Summary is longer than 50 chars ({})".format(len(summary)))
        return False

    return True


def check_commit_msg(commit_msg: str) -> bool :
    """
    Checks the full commit message.
    """
    # Remove comments
    raw_lines: List[str] = commit_msg.splitlines()
    lines: List[str] = [x for x in raw_lines if not x.startswith("#")]

    # Check summary
    valid: bool = check_summary(lines[0])

    # Check body if any
    if len(lines) > 2:
        # There must be a separation line
        if lines[1]:
            valid = False
            print("[ERR] No separation line between summary and body")
        
        valid &= check_body(lines[2:])

    # Last line must not be blank
    if len(lines) > 1 and not lines[-1]:
        valid = False
        print("[ERR] Last line must not be blank")

    return valid
    
def test():
    print(check_summary("Hello"))


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("usage: commit_msg.py COMMIT_MSG_FILE")
        sys.exit(2)

    valid: bool = check_commit_msg(open(sys.argv[1]).read())
    sys.exit(0 if valid else 1)
