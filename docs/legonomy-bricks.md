# LeoFeed Legonomy Bricks

LeoFeed is built from small, explicit Leopard-native bricks.

## Core Bricks

### LeoFeedCore

Purpose:
Owns the basic feed reader domain model.

Initial concepts:
- feed
- article
- folder
- enclosure
- read state
- flagged state

Rule:
No AppKit dependency. Core should be Foundation-level where possible.

### LeoFeedStore

Purpose:
Stores feeds, articles, folders, and read states locally.

Initial backend:
SQLite, based on Vienna's proven storage model.

Rule:
The store must be isolated behind a small explicit API so the SQLite
implementation can later be reviewed or replaced.

### LeoFeedParsing

Purpose:
Parses feed formats into LeoFeedCore objects.

Initial formats:
- RSS
- Atom

Later:
- JSON Feed

Rule:
Parser robustness matters more than theoretical purity.

### LeoFeedFetch

Purpose:
Fetches feed data from local files and network URLs.

V1:
Use Leopard-compatible networking.

Later:
Evaluate a separate modern HTTPS transport brick if feed fetching itself fails
on modern TLS endpoints.

### LeoFeedUI

Purpose:
Native Leopard Cocoa user interface.

V1:
- feed list
- article list
- local article rendering
- external open for original links

Rule:
LeoFeedUI must not become a modern browser.

### LeoFeedScript

Purpose:
AppleScript and future LeooRexx-facing command surface.

V1:
Study Vienna's script suite and terminology.

Later:
Services and LeooRexx integration.

## Boundary Rule

A brick may depend downward, not sideways through hidden globals.

Preferred direction:
UI -> Script/Core/Store/Fetch/Parsing
Fetch -> Parsing/Core
Parsing -> Core
Store -> Core
Core -> Foundation only
