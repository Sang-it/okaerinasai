#!/usr/bin/env python3
"""Static server for the Bonsai SPA.

- Serves /main.bc.js straight from the dune build output (_build/default/bin/)
  when it exists, so you never have to copy the 25 MB bundle into static/.
  Falls back to static/main.bc.js otherwise.
- Falls back to index.html for unknown paths, so client-side routes like
  /blog/:slug and /projects/:slug work on reload / deep-link.
- Warns loudly at startup if the bundle it would serve is missing or empty
  (an empty bundle is what makes the page render blank with no error).
"""

import http.server, os, sys

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.join(HERE, "static")
BUNDLE_BUILD = os.path.join(HERE, "_build", "default", "bin", "main.bc.js")
BUNDLE_STATIC = os.path.join(ROOT, "main.bc.js")
PORT = int(sys.argv[1]) if len(sys.argv) > 1 else 8099


def bundle_path():
    """Prefer the freshly built bundle; fall back to the staged copy."""
    if os.path.exists(BUNDLE_BUILD) and os.path.getsize(BUNDLE_BUILD) > 0:
        return BUNDLE_BUILD
    return BUNDLE_STATIC


class Handler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *a, **k):
        super().__init__(*a, directory=ROOT, **k)

    def do_GET(self):
        # Serve the JS bundle from wherever a non-empty copy exists.
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
            # unknown route -> serve the SPA shell
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
