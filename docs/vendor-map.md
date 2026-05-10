# LeoFeed Vendor Map: Vienna RSS 2.6.0.2600

This document maps the frozen Vienna RSS 2.6.0.2600 vendor baseline into
LeoFeed-relevant areas.

Vendor rule:
Files under `vendor/` are historical reference material and must not be edited
directly. LeoFeed development happens outside `vendor/`.

## Baseline

- Upstream: Vienna RSS
- Vendor path: `vendor/vienna-rss/`
- Upstream tag: `repl/c9e39d77-p2.6.0.2600`
- Upstream commit: `63e50a9256aa4055c3500784f995e436f73d8866`
- Version: Vienna 2.6.0
- Build: 2600
- Minimum system: Mac OS X 10.5.0
- SDK: macosx10.5
- Compiler: Apple GCC 4.2
- Architecture intent: PowerPC + Intel

## System Integration

Vienna 2.6 is a classic native Cocoa application. It uses Leopard-era system
facilities and does not depend on foreign GUI runtimes such as GTK, Qt, Java, or
Electron.

Observed system-facing areas:

- Cocoa/AppKit via classic `.nib` resources
- WebKit.framework for article and browser display
- Security.framework / Keychain for credentials
- SystemConfiguration.framework for network-related state
- IOKit.framework for system/power related integration
- AppleScript / OSA through script suite and terminology files
- Launch Services integration for feed URLs, plugins, styles, OPML, and scripts
- SQLite-based local storage

Not observed as primary foundations:

- PubSub.framework
- Core Data
- Spotlight / NSMetadata
- Quick Look
- Sync Services
- Automator
- Scripting Bridge
- QuickTime

## Keep / Study First

These areas appear central to the working Leopard/PPC feed reader core.

### Core Model

- `Message.h/.m`
- `ArticleRef.h/.m`
- `Folder.h/.m`
- `Field.h/.m`
- `TreeNode.h/.m`
- `Criteria.h/.m`
- `SearchFolder.h/.m`

### Store

- `Database.h/.m`
- `SQLDatabase.h/.m`
- `SQLDatabasePrivate.h`
- `SQLRow.m`
- `SQLResult.m`
- `documents/DatabaseSchema.doc`

### Parsing

- `XMLParser.h/.m`
- `RichXMLParser.h/.m`
- `XMLTag.h/.m`
- `CurlGetDate/`
- `StringExtensions.h/.m`
- `CalendarExtensions.h/.m`

### Fetching

- `RefreshManager.h/.m`
- `AsyncConnection.h/.m`
- `FeedCredentials.h/.m`
- `KeyChain.h/.m`

### UI

- `AppController.h/.m`
- `ArticleView.h/.m`
- `ArticleListView.h/.m`
- `BrowserPane.h/.m`
- `BrowserView.h/.m`
- `FoldersTree.h/.m`
- `MainMenu.nib`
- `SearchPanel.nib`

### Scripting

- `ViennaApp.h/.m`
- `ViennaApp.scriptSuite`
- `ViennaApp.scriptTerminology`
- `URLHandlerCommand.h/.m`

## Remove / Exclude From V1

These areas are not part of the LeoFeed V1 scope.

- `Sparkle.framework`
- `Growl.framework`
- `BitlyAPIHelper.h/.m`
- social sharing plugins
- old web service plugins
- portable mode
- release scripts
- `sign_update.rb`
- `generate_keys.rb`

Rationale:
LeoFeed V1 is a local Leopard/PPC feed reader, not a social sharing client,
auto-update platform, or modern web-service integration layer.

## Review Later

These areas may be useful but should not be pulled into LeoFeed V1 without a
separate decision.

- `PSMTabBarControl.framework`
- `TabbedWebView.h/.m`
- `Styles/`
- `SyntaxHighlighter/`
- `PluginManager.h/.m`
- toolbar/plugin integration
- bundled `sqlite/sqlite3.c`
- bundled `sqlite/sqlite3.h`

## Redundancy Review

### PubSub.framework

Vienna manages feeds itself and does not appear to use Leopard's PubSub.framework
as its foundation.

Decision:
Do not replace the working Vienna feed core with PubSub in V1.

Reason:
The Vienna feed core builds and runs on Leopard/PPC. PubSub remains a review
candidate, but using it as the V1 foundation would increase risk.

### SQLite

Vienna bundles its own SQLite source and wraps it through `SQLDatabase`.

Leopard provides system SQLite, but Vienna may depend on behavior from its
bundled SQLite and wrapper layer.

Decision:
Keep the vendor baseline unchanged. For LeoFeed, evaluate system `libsqlite3`
only after mapping Vienna's SQL wrapper and custom behavior.

### XML Parsing

Vienna uses its own XML parser layer over CoreFoundation-style XML handling,
rather than building the whole feed parser on higher-level Foundation XML APIs.

Decision:
Study before replacing. Feed parsing needs robustness against real-world broken
feeds.

### WebKit

Vienna uses WebKit for display. This is Leopard-native, but modern HTTPS pages
may fail in the embedded web view.

Decision:
LeoFeed V1 renders feed-provided article content locally. Loading original
modern HTTPS article pages is optional and outside the core promise.

## Doctrine

LeoFeed is not a Vienna rename.

LeoFeed inherits Vienna's working Leopard/PPC feed reader core as reference
material, but every subsystem must be re-evaluated against native Leopard
capabilities.

Guiding rule:
Use the working Vienna core where it is small, native, and proven. Replace or
remove bundled subsystems where Leopard already provides a cleaner native
capability or where the subsystem is outside LeoFeed V1 scope.
