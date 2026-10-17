# Chrome Web Store listing — Lily in Chrome

Copy these into the Developer Dashboard fields.

## Name
Lily in Chrome

## Summary (≤132 chars)
Let Lily, Pathvela's AI assistant, drive your own browser — your tabs and
sign-ins — to do web tasks you ask it to.

## Category
Workflow & Planning (or Developer Tools)

## Single purpose (required)
Lily in Chrome lets Lily — Pathvela's AI assistant — carry out web tasks in the
user's own browser on the user's behalf, by driving the tabs in a dedicated
"Lily" tab group. Everything else (the recorder, voice typing, the ambient
border) exists to support that one purpose.

## Detailed description
Lily can already use a browser on its own. But to do things on *your* accounts —
post, reply, fill a form, check an order — it needs *your* logged-in browser, and
attaching over DevTools makes Chrome nag "An external app wants full control…"
every time.

Lily in Chrome fixes that. The extension holds the automation permission itself,
granted once at install, and becomes the transport Lily drives through:

- **Your real browser** — your tabs and your sign-ins, so Lily acts as you.
- **No remote-debugging prompt**, ever again.
- **A yellow ambient border** on any tab Lily is driving, so control is always
  visible, and a **"Lily" tab group** that keeps agent tabs out of your way —
  Lily only ever touches tabs in its own group.
- **Free, multilingual voice typing** into the focused field (Alt+Shift+D).
- Works as a transport for Lily's own browser use: installed, Lily routes through
  it; not installed, Lily falls back to a standalone browser.

Requires the Lily / Pathvela app and its native messaging host (see install
instructions).

## Permission justifications (paste per-permission)
- **debugger** — The extension drives the page via the Chrome DevTools Protocol
  (clicks, typing, navigation, screenshots) to perform the tasks the user asks
  Lily to do, in the user's own browser. This replaces the repeated
  "allow remote debugging" prompt with a one-time install grant. It is used only
  on tabs in the Lily tab group the user initiated.
- **nativeMessaging** — To exchange automation commands and results with the
  locally-installed Lily native host; no browsing data leaves the machine except
  as needed to perform the requested task.
- **tabs** — To identify and operate on the correct tab within Lily's own group.
- **scripting / activeTab** — To read page structure and dispatch the requested
  actions on the page the user asked Lily to act on.
- **tabGroups / windows** — To create and manage the dedicated "Lily" tab group
  so agent tabs stay separate from the user's own tabs.
- **host_permissions `<all_urls>`** — The user may ask Lily to act on any site
  they are signed into; access is used only on Lily-group tabs during a task.
- **storage** — Local extension settings (humanization preferences) only.
- **alarms** — Keep the service worker responsive while a task is attached.
- **offscreen** — Render audio/transcription for voice typing.
- **clipboardWrite** — Paste content when a task requires it.

## Privacy
- Data use: performs the user's requested actions only; not sold or used for
  ads/profiling. Privacy policy URL: https://pathvela.com/lily-in-chrome/privacy
  (hosted in poolotlms; `store/privacy-policy.md` is the source text).
- Visibility recommendation: **Unlisted** (companion/automation tool).
