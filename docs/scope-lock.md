# LeoFeed Scope Lock

LeoFeed is a Leopard/PPC-native feed reader inspired by Vienna RSS.

V1 includes:
- RSS and Atom feed reading
- local SQLite-backed feed/article storage
- OPML import/export
- native Cocoa main window
- WebKit article display
- basic enclosure handling
- AppleScript-aware command surface where practical

V1 excludes:
- cloud sync
- modern account services
- social sharing plugins
- Sparkle auto-update integration
- rewriting Vienna wholesale
- editing files under vendor/

Design doctrine:
LeoFeed is not a Vienna rename. Vienna is historical reference material.
LeoFeed is a Cupertino-2009 recomposition for Mac OS X 10.5.8 PowerPC.

HTTPS/Web limitation:
LeoFeed V1 is not a modern web browser. It must render feed-provided article
content locally. Loading original HTTPS article pages through the embedded
Leopard WebKit view is optional and may fail on modern sites due to Leopard-era
TLS, certificate, and WebKit limitations.
