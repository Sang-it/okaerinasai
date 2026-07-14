#!/usr/bin/env python3
import http.server, os, sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.join(HERE, "static")
BUNDLE_BUILD = os.path.join(HERE, "_build", "default", "bin", "main.bc.js")
BUNDLE_STATIC = os.path.join(ROOT, "main.bc.js")
PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 8099


def bundle_path():
    if os.path.exists(BUNDLE_BUILD) and os.path.getsize(BUNDLE_BUILD) > 0:
        return BUNDLE_BUILD
    return BUNDLE_STATIC


class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *a, **k):
        super().__init__(*a, directory=ROOT, **k)

    def do_GET(self):
        if self.path.split("?")[0] in ("/main.bc.js", "/main.bc.js/"):
            b = bundle_path()
            if os.path.exists(b) and os.path.getsize(b) > 0:
                self.send_response(200)
                self.send_header("Content-Type", "text/javascript")
                self.send_header("Content-Length", str(os.path.getsize(b)))
                self.end_headers()
                with open(b, "rb") as f:
                    self.copyfile(f, self.wfile)
                return
        path = self.translate_path(self.path)
        if not os.path.exists(path) or os.path.isdir(path):
            if not (
                os.path.isdir(path) and os.path.exists(os.path.join(path, "index.html"))
            ):
                self.path = "/index.html"
        return super().do_GET()


if __name__ == "__main__":
    b = bundle_path()
    if not os.path.exists(b) or os.path.getsize(b) == 0:
        print(
            "WARNING: JS bundle is missing or empty — the page will render BLANK.\n"
            "  Build it first:  dune build bin/main.bc.js\n"
            f"  Looked for:      {BUNDLE_BUILD}\n"
            f"            and:   {BUNDLE_STATIC}",
            file=sys.stderr,
        )
    else:
        print(f"serving bundle: {b} ({os.path.getsize(b):,} bytes)", file=sys.stderr)
    print(f"http://localhost:{PORT}/", file=sys.stderr)
    http.server.HTTPServer(("127.0.0.1", PORT), Handler).serve_forever()
