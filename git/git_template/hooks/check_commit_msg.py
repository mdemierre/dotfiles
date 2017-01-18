#!/usr/bin/env python3
"""
Checks the commit log message.

Called by "git commit" with one argument, the name of the file
that has the commit message.  The hook should exit with non-zero
status after issuing an appropriate message if it wants to stop the
commit.  The hook is allowed to edit the commit message file.
"""

import sys
import os
import subprocess
from subprocess import CompletedProcess
from typing import List, Tuple

EDITOR = os.getenv('EDITOR', 'vim')

def check_body(body_lines: List[Tuple[str, int]]) -> List[str]:
    """
    Checks the message body.
    """
    errors: List[str] = []

    for line, line_nb in body_lines:
        line_length = len(line)
        if(line_length > 72):
            errors.append("Body: line {} is too long ({})".format(line_nb, line_length))
    
    return errors


def check_summary(summary: str) -> List[str]:
    """
    Checks the summary line.
    """
    errors: List[str] = []
    
    if(len(summary) > 50):
        errors.append("Summary: longer than 50 chars ({})".format(len(summary)))

    return errors


def check_commit_msg(commit_msg: str) -> List[str] :
    """
    Checks the full commit message.
    """
    # Remove comments
    errors: List[str] = []
    raw_lines = commit_msg.splitlines()
    raw_lines_numbered = zip(raw_lines, range(1, len(raw_lines) + 1))
    lines_numbered: List[str] = [
        (line, number) for line, number in raw_lines_numbered if not line.startswith("#")
    ]

    # Check summary
    errors.extend(check_summary(lines_numbered[0][0]))

    # Check body if any
    if len(lines_numbered) > 2:
        # There must be a separation line
        if lines_numbered[1][0]:
            errors.append("No separation line between summary and body")
        
        # Check the rest of the body
        errors.extend(check_body(lines_numbered[2:]))

    # Last line must not be blank
    if len(lines_numbered) > 1 and not lines_numbered[-1][0]:
        errors.append("Last line must not be blank")

    return errors
    
def test():
    print(check_summary("Hello"))


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("usage: commit_msg.py COMMIT_MSG_FILE")
        sys.exit(2)

    commit_msg = open(sys.argv[1]).read()
    
    errors = check_commit_msg(commit_msg)
    while errors:
        print('Invalid git commit message format:')
        print('\n'.join(["  - {}".format(err) for err in errors]))
        print()
        choice: str = input('Press y to edit and n to cancel the commit. [y/n]:')
        if choice in ['n', 'no']:
            print("Canceled commit.")
            sys.exit(1)
        else:
            completedProcess: CompletedProcess = subprocess.run([EDITOR, sys.argv[1]])
            if completedProcess.returncode != 0:
                sys.exit(completedProcess.returncode)
            else:
                errors = check_commit_msg(commit_msg) 

    sys.exit(0)
