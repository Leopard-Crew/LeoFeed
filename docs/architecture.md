# LeoFeed Architecture

LeoFeed is a Mac OS X 10.5.8 Leopard / PowerPC native feed reader.

Design rules:
- Leopard-native Cocoa first.
- No work inside vendor/.
- Vienna 2.6 is reference material, not the product identity.
- Reuse Leopard capabilities where adequate.
- Keep components small and explicit.

Initial component split:
- Sources/LeoFeedCore: feed, article, folder and enclosure model
- Sources/LeoFeedParsing: RSS, Atom and later JSON Feed parsing
- Sources/LeoFeedStore: SQLite persistence
- Sources/LeoFeedFetch: feed fetching via Leopard-compatible networking
- Sources/LeoFeedUI: native Cocoa UI
- Sources/LeoFeedScript: AppleScript / future LeooRexx-facing command surface
