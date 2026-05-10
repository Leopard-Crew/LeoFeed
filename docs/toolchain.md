# LeoFeed Toolchain

Target system:
- Mac OS X 10.5.8 Leopard
- PowerPC G5

Primary compiler:
- Apple GCC 4.2.1
- Binary: /usr/bin/gcc-4.2
- Darwin target: powerpc-apple-darwin9
- Apple build: 5577

Default system gcc points to gcc-4.0, but the historical Vienna 2.6 project
explicitly requests GCC_VERSION = 4.2.

Build doctrine:
- Use Apple/Xcode toolchain first.
- Do not use MacPorts GCC for Cocoa application builds unless explicitly isolated.
- Keep vendor/ immutable; use external build directories for tests.
