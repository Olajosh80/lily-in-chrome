# Chrome Web Store Submission Checklist — Lily in Chrome (`v1.0.0`)

## 1. Package Artifact
- [x] **Manifest V3 verified** (`extension/manifest.json`: `"manifest_version": 3`, `"version": "1.0.0"`, `"minimum_chrome_version": "116"`).
- [x] **Icons verified** (`extension/icons/icon16.png` 16×16, `icon48.png` 48×48, `icon128.png` 128×128 RGBA PNG).
- [x] **Production ZIP built** via `npm run build` → `dist/lily-in-chrome-1.0.0.zip` (~286 KB, 30 files, `manifest.json` at archive root, no `.DS_Store` or `.git` artifacts).

## 2. Store Listing Copy (`store/listing.md`)
- [x] **Title**: `Lily in Chrome`
- [x] **Summary (≤132 chars)**: Prepared in `store/listing.md`.
- [x] **Detailed description**: Prepared in `store/listing.md` (explains browser transport, yellow ambient border, dedicated "Lily" tab group, voice typing, and native host requirement).
- [x] **Category**: `Workflow & Planning` (or `Developer Tools`).

## 3. Visual Assets / Screenshots (Required Before Submit)
- [ ] **Screenshots (1–5 required)**: 1280×800 or 640×400 (24-bit PNG or JPEG, no alpha).
  - Recommended shot 1: Browser tab inside the `"Lily"` tab group with the yellow ambient border active while Lily drives a task.
  - Recommended shot 2: Toolbar badge status + Options / Recorder page (`recorder/options.html`).
- [x] **Store icon**: `extension/icons/icon128.png` (128×128 PNG).
- [ ] **Small promo tile (optional)**: 440×280 PNG/JPEG.

## 4. Privacy & Permissions Tab (`store/listing.md` & `store/privacy-policy.md`)
- [x] **Single-purpose description**: Prepared in `store/listing.md`.
- [x] **Permission justifications** (paste per-permission from `store/listing.md`):
  - `debugger`, `nativeMessaging`, `tabs`, `scripting`, `activeTab`, `tabGroups`, `windows`, `storage`, `alarms`, `offscreen`, `clipboardWrite`, and `host_permissions` (`<all_urls>`).
- [ ] **Privacy policy URL live check**: Confirm `https://pathvela.com/lily-in-chrome/privacy` (sourced from `store/privacy-policy.md`) is live before hitting Submit.
- [ ] **Data use certifications**: Declare that page content/context is used solely to execute user-requested tasks via Lily/Pathvela and is never sold or used for advertising/profiling.

## 5. First-Time Upload & Release Gate (`DEPLOY.md`)
- [ ] Upload `dist/lily-in-chrome-1.0.0.zip` in the [Chrome Web Store Developer Console](https://chrome.google.com/webstore/devconsole).
- [ ] Set **Visibility** (`Unlisted` recommended for companion tool, or `Public` per release decision).
- [ ] Verify assigned **Item ID** matches `oofliicdlmpffmhpnlacglocdoaehpgg` (or update `EXTENSION_ID` in `.env` and native host per `DEPLOY.md`).
