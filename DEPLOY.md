# Deploying Lily in Chrome to the Chrome Web Store

Two phases: a **one-time setup** (create the item + API credentials), then
**`npm run deploy`** for every release after.

---

## One-time setup

### 1. Register + create the item (manual, once)
The Web Store API can *update* an item but can't *create* the first one.

1. Pay the one-time **$5** developer fee at
   <https://chrome.google.com/webstore/devconsole>.
2. **Add new item** → upload `dist/lily-in-chrome-1.0.0.zip` (run `npm run build`
   first).
3. Fill the listing from [`store/listing.md`](store/listing.md) and set the
   **privacy policy URL** to `https://pathvela.com/lily-in-chrome/privacy`
   (hosted in poolotlms at `app/lily-in-chrome/privacy`; deploy poolotlms so it is
   live before you submit).
4. Set **Visibility = Unlisted** (recommended for a companion/automation tool),
   then **Submit**. Note the **Item ID** it assigns.
5. If that Item ID is **not** `oofliicdlmpffmhpnlacglocdoaehpgg`, the key wasn't
   honored — put the real Item ID in `.env` (`EXTENSION_ID`) and also register it
   with the native host: `./install.sh oofliicdlmpffmhpnlacglocdoaehpgg <item-id>`.

### 2. Enable the API + OAuth client
1. In <https://console.cloud.google.com> create (or pick) a project.
2. **APIs & Services → Library →** enable **Chrome Web Store API**.
3. **Credentials → Create credentials → OAuth client ID → Desktop app.**
   Copy the **Client ID** and **Client secret** into `.env`.

### 3. Get a refresh token (once)
Follow Google's current [Chrome Web Store API authorization guide](https://developer.chrome.com/docs/webstore/using-api)
using the developer account that owns the store item and the
`https://www.googleapis.com/auth/chromewebstore` scope. Use the guide's OAuth
Playground flow and its required client/redirect configuration, or a supported
Desktop-app loopback flow. Do not use the retired `urn:ietf:wg:oauth:2.0:oob`
copy/paste flow.

Store `CLIENT_ID`, `CLIENT_SECRET`, `REFRESH_TOKEN`, and `EXTENSION_ID` in the
ignored `.env`. Refresh tokens can expire or be revoked; reauthorize if refresh
fails. Never commit or paste tokens into build logs.

### Submission checks
- Confirm the privacy-policy URL loads and complete the dashboard's privacy,
  permissions justification, screenshots, and reviewer instructions.
- Unlisted still requires review; submission is not immediate availability.
- Confirm the actual store-assigned item ID and register it with the native host.
- For the first submission, use the dashboard. For later uploads, `npm run upload`
  leaves publication under dashboard control. The pinned upload CLI is a separate
  integration from Google's current v2 API; verify its response before claiming
  publication succeeded.

---

## Every release
1. Bump `version` in BOTH `extension/manifest.json` and `package.json` (and refresh the lockfile). The builder reads the manifest version; upload scripts read the package version.
2. Load the creds and deploy:
   ```bash
   set -a; source .env; set +a
   npm install        # first time only, pulls chrome-webstore-upload-cli
   npm run deploy            # build + upload + publish (Unlisted/Public per listing)
   # or:
   npm run deploy:testers   # publish to trusted testers first
   npm run upload           # upload only, publish by hand in the dashboard
   ```

`npm run deploy` runs `scripts/build.sh` then `chrome-webstore-upload`, which
reads `EXTENSION_ID`, `CLIENT_ID`, `CLIENT_SECRET`, `REFRESH_TOKEN` from the env.

> Reminder: `key.pem` is the extension's identity — back it up securely and never
> commit it. `.env` holds live secrets and is gitignored.
