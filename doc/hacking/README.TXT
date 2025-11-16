1. Default build:
time rake 2>&1 | tee default_build.log

2. Clean with:
rake clean

===

I added to new build_configs:

freestanding-host-minimal.rb
freestanding-cross-minimal.rb

===

TO-DO:

- Implement libc functions or use picolibc.
