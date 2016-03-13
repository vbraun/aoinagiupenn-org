#!/usr/bin/env python3

import sys
import os

from livereload import Server

REPO_ROOT = os.path.dirname(os.path.dirname(__file__))

CONTENT = os.path.join(REPO_ROOT, 'content')
OUTPUT = os.path.join(REPO_ROOT, 'output')


if __name__ == '__main__':
    os.chdir(REPO_ROOT)
    server = Server()
    server.watch('content', 'pelican')
    server.watch('*.py', 'pelican')
    server.watch('theme/scss', 'make scss')
    # server.watch('output')
    server.serve(
        root='output',
    )
