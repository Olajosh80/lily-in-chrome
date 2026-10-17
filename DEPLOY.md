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
   **privacy policy URL** (host [`store/privacy-policy.md`](store/privacy-policy.md)
   somewhere, e.g. `https://pathvela.com/lily-in-chrome/privacy`).
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
Grant your own account access and capture the refresh token:
1. Open (replace CLIENT_ID):
   `https://accounts.google.com/o/oauth2/auth?response_type=code&scope=https://www.googleapis.com/auth/chromewebstore&access_type=offline&prompt=consent&redirect_uri=urn:ietf:wg:oauth:2.0:oob&client_id=CLIENT_ID`
2. Approve → copy the code, then exchange it:
   ```bash
   curl -s https://oauth2.googleapis.com/token \
     -d client_id=$CLIENT_ID -d client_secret=$CLIENT_SECRET \
     -d code=PASTE_CODE -d grant_type=authorization_code \
     -d redirect_uri=urn:ietf:wg:oauth:2.0:oob | grep refresh_token
   ```
3. Put the `refresh_token` into `.env` (`REFRESH_TOKEN`). It does not expire.

---

## Every release
1. Bump `version` in `extension/manifest.json`.
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
