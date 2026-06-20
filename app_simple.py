#!/usr/bin/env python3
"""Minimal web server for churn risk analyzer - zero dependencies."""

import os
from http.server import HTTPServer, SimpleHTTPRequestHandler
import threading
import time

class CORSRequestHandler(SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        super().end_headers()

    def do_GET(self):
        if self.path == '/' or self.path == '':
            self.path = '/index.html'
        return super().do_GET()

    def do_OPTIONS(self):
        self.send_response(200)
        self.end_headers()

if __name__ == '__main__':
    os.chdir(os.path.dirname(os.path.abspath(__file__)))

    port = int(os.environ.get('PORT', 7860))
    server = HTTPServer(('0.0.0.0', port), CORSRequestHandler)

    print(f'Server running on port {port}')
    print(f'Open http://localhost:{port} in your browser')

    try:
        server.serve_forever()
    except KeyboardInterrupt:
        print('\nShutting down...')
        server.shutdown()
