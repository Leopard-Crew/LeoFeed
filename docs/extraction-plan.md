# LeoFeed Extraction Plan

LeoFeed is not a rename of Vienna RSS.

Vienna 2.6.0.2600 is a frozen, buildable Leopard/PPC reference baseline.
LeoFeed development happens outside `vendor/`.

## Phase 1: Mapping and Isolation

Goal:
Understand Vienna's working feed reader core and isolate the smallest useful
LeoFeed components without modifying vendor files.

Tasks:
- Keep vendor clean and immutable.
- Build vendor only through temporary working copies.
- Map core model, store, parsing, fetching, UI, and scripting boundaries.
- Identify V1 removals before importing code.

## Phase 2: LeoFeed Skeleton

Goal:
Create a minimal native Leopard Cocoa application independent from the Vienna
vendor project.

Initial structure:
- `Sources/LeoFeedCore`
- `Sources/LeoFeedStore`
- `Sources/LeoFeedParsing`
- `Sources/LeoFeedFetch`
- `Sources/LeoFeedUI`
- `Sources/LeoFeedScript`
- `Resources`
- `LeoFeed.xcodeproj`

Rules:
- Use Apple GCC 4.2 and macosx10.5 SDK.
- Keep Objective-C/Cocoa first.
- Do not introduce MacPorts dependencies for the Cocoa app core.
- Do not copy large Vienna UI sections before the model/store/parser boundary is clear.

## Phase 3: Core Model

Candidate vendor references:
- `Message.h/.m`
- `ArticleRef.h/.m`
- `Folder.h/.m`
- `Field.h/.m`
- `TreeNode.h/.m`
- `Criteria.h/.m`
- `SearchFolder.h/.m`

Goal:
Define LeoFeed's own feed, article, folder, enclosure, and read-state model.

## Phase 4: Storage

Candidate vendor references:
- `Database.h/.m`
- `SQLDatabase.h/.m`
- `SQLDatabasePrivate.h`
- `SQLRow.m`
- `SQLResult.m`
- `documents/DatabaseSchema.doc`
- `sqlite/`

Goal:
Build a minimal SQLite-backed local store for feeds and articles.

Decision points:
- Keep bundled SQLite temporarily if needed.
- Review system `libsqlite3` later.
- Avoid Core Data for V1.

## Phase 5: Parsing

Candidate vendor references:
- `XMLParser.h/.m`
- `RichXMLParser.h/.m`
- `XMLTag.h/.m`
- `CurlGetDate/`
- `StringExtensions.h/.m`
- `CalendarExtensions.h/.m`

Goal:
Support RSS and Atom first.

Later:
- JSON Feed support.
- Parser hardening against real-world broken feeds.

## Phase 6: Fetching

Candidate vendor references:
- `RefreshManager.h/.m`
- `AsyncConnection.h/.m`
- `FeedCredentials.h/.m`
- `KeyChain.h/.m`

Goal:
Fetch RSS/Atom feed data on Leopard/PPC.

Boundaries:
- Feed fetching is core.
- Loading original article web pages is not core.
- Modern HTTPS limitations are accepted for V1 unless feed fetching itself fails.

Later:
- Evaluate a separate `LeoFetch` or `LeoTLSFetch` brick for modern HTTPS feeds.

## Phase 7: UI

Candidate vendor references:
- `AppController.h/.m`
- `ArticleView.h/.m`
- `ArticleListView.h/.m`
- `BrowserPane.h/.m`
- `BrowserView.h/.m`
- `FoldersTree.h/.m`
- `MainMenu.nib`
- `SearchPanel.nib`

Goal:
Create a calm native Leopard Cocoa UI.

V1 UI:
- feed/folder list
- article list
- local WebKit article rendering
- external browser opening for original links

Avoid in V1:
- tabbed browser complexity
- social plugin toolbars
- modern web browsing expectations

## Phase 8: Scripting

Candidate vendor references:
- `ViennaApp.h/.m`
- `ViennaApp.scriptSuite`
- `ViennaApp.scriptTerminology`
- `URLHandlerCommand.h/.m`

Goal:
Preserve and later refine a scriptable command surface.

Future direction:
- AppleScript first.
- LeooRexx compatibility later.
- Native Services integration where appropriate.

## Explicit V1 Exclusions

- Cloud sync
- Social sharing plugins
- Sparkle auto-update integration
- Growl dependency
- PSM tabbed browser dependency
- Portable mode
- Modern web browser replacement
- Editing files under `vendor/`

## Doctrine

Use Vienna's working Leopard/PPC feed core where it is proven, small, and native.
Remove or replace subsystems that are obsolete, service-dependent, redundant, or
outside LeoFeed V1 scope.
