<p align="center">
  <img src="extension/icons/icon128.png" width="96" alt="Lily in Chrome">
</p>

<h1 align="center">Lily in Chrome</h1>

<p align="center">
  Let <strong>Lily</strong> drive your real browser — your tabs, your sign-ins —
  from Pathvela, without Chrome's "Allow remote debugging?" prompt ever again.
</p>

---

## Why this exists

Lily can already use a browser on its own. But when it drives *your* everyday
Chrome — the one with your logged-in accounts — it attaches over the DevTools
protocol, and modern Chrome throws up **"An external app wants full control over
this Chrome session"** every single time. Clicking *Allow* over and over is
miserable.

This extension fixes that the right way: it holds the `chrome.debugger`
permission itself, granted **once at install**. After that Lily drives the page
through the extension — no prompt, no re-approving, reliable on and off.

## What you get

- **No remote-debugging prompt** — ever again.
- **Your real browser** — your tabs and your sign-ins, so Lily can actually do
  things on your accounts (post, reply, fill forms) as you.
- **A yellow ambient border** around any tab Lily is driving, so you always know
  when the browser is under agent control.
- **Tabs grouped as "Lily"** so agent-opened tabs stay out of your way.
- **Works with Lily's own browser-use** — the extension is a *transport*. When
  it's installed, Lily routes browser actions through it; when it isn't, Lily
  falls back to its built-in path. Same Lily, smoother ride.

## How it connects to Lily (the harness)

```
  Chrome tab ──chrome.debugger──▶ Lily-in-Chrome extension
                                        │  native messaging
                                        ▼
                                   native host  (com.pathvela.lily_in_chrome)
                                        │  local bridge, Pathvela-token secured
                                        ▼
                                   Lily  (daemon / Pathvela)
```

The extension never talks to the internet on its own. It speaks only to a small
**native host** on your machine, which bridges to your **Lily** sessions over a
local, token-authenticated channel — the same Pathvela identity Lily already
uses. One machine, one host, every Lily session in sync.

## Install (developer / unpacked)

> First-time local setup, until a packed build is published.

**1. Register the native host** (lets Chrome talk to Lily on your machine):

```bash
cd lily-in-chrome
./install.sh
```

This writes the native-messaging manifest for `com.pathvela.lily_in_chrome` and
points it at the host in `host/`.

**2. Load the extension unpacked:**

1. Open `chrome://extensions` (works in any Chromium browser — Chrome, Brave, Edge).
2. Turn on **Developer mode** (top-right).
3. Click **Load unpacked** and select the `lily-in-chrome/extension` folder.
4. Pin the Lily icon so you can see its status badge.

**3. Connect Lily:** start Lily as usual. When the extension is present Lily uses
it automatically; you'll see the **yellow border** the first time Lily touches a
tab.

To update after a code change: edit the files, then hit **Reload** on the card in
`chrome://extensions`.

## Status badge

The toolbar icon shows what Lily is doing at a glance: amber while connecting,
green when a step lands, red on an error. The on-page **yellow border** shows
which tab is actively being driven.

## Permissions, honestly

`debugger`, `tabs`, `tabGroups`, `scripting`, `nativeMessaging` — everything
needed to drive a page and group tabs, and nothing that phones home. Host access
is `<all_urls>` because Lily goes where you send it; it acts only when you ask it
to.

## Credits

Built on the open-source **Open Claude in Chrome** project (MIT). Rebuilt and
rewired for Lily / Pathvela. See `LICENSE`.
