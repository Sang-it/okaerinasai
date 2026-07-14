
build:
    dune build static/main.bc.js

release:
    dune build --profile release static/main.bc.js

watch:
    dune build -w static/main.bc.js

serve:
    python3 serve.py 8099

fmt:
    dune fmt

check:
    dune build

clean:
    dune clean
