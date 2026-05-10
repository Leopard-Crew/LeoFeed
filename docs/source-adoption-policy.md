# LeoFeed Source Adoption Policy

LeoFeed may use Vienna RSS 2.6.0.2600 source material, but it must not become a
simple Vienna rename.

## Rules

1. Files under `vendor/` are read-only reference material.
2. Adopted code must move into LeoFeed-owned source directories.
3. Adopted code must be reviewed for dependencies before import.
4. Obsolete service integrations must not be carried forward blindly.
5. Headers must preserve original copyright/license notices where applicable.
6. New LeoFeed code uses the `LF` prefix.
7. Each imported subsystem must become a small, explicit Legonomy brick.
8. Prefer Leopard-native APIs where they are adequate and simpler.
9. Do not introduce MacPorts dependencies into the Cocoa application core.
10. First extract core, store, parser, and fetch boundaries before UI migration.

## Adoption Rings

Ring 1: likely adoption
- core feed/article/folder model
- SQLite store layer
- RSS/Atom parser
- OPML handling
- Keychain credential handling
- AppleScript command ideas

Ring 2: study before adoption
- refresh manager
- preferences
- article rendering
- styles
- UI controllers

Ring 3: exclude from V1
- Sparkle
- Growl
- social sharing plugins
- Bitly
- PSM tabbed browser layer
- portable mode
- release scripts

## Doctrine

Use Vienna where it is proven, native, small, and useful.

Do not inherit Vienna where it is obsolete, service-dependent, redundant, or
outside LeoFeed V1 scope.
