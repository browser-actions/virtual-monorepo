# browser-actions virtual-monorepo

This is a virtual monorepo for the [browser-actions](https://github.com/browser-actions) GitHub organization. It serves as a unified workspace for working across the organization's distributed repositories, each of which lives in its own GitHub repo.

## Organization Overview

The browser-actions org publishes GitHub Actions for installing browsers and related tools:

| Repo | Purpose |
|------|---------|
| `setup-chrome` | Install Chrome/Chromium (stable, dev, beta, canary, snapshot, or version number) |
| `setup-firefox` | Install Firefox |
| `setup-edge` | Install Microsoft Edge |
| `setup-geckodriver` | Install geckodriver |
| `release-chrome-extension` | Publish a Chrome extension to the Web Store |
| `release-firefox-addon` | Publish a Firefox addon to AMO |
| `actions-swing` | Shared helper library used by the setup-* actions |

## Per-repo Development Workflow

Each action repo follows the same structure and toolchain:

**Package manager:** `pnpm` (lockfile is `pnpm-lock.yaml`)

**Commands (run inside the individual repo directory):**
```sh
pnpm install --frozen-lockfile  # install dependencies
pnpm lint                       # lint with Biome (CI mode, no auto-fix)
pnpm lint:fix                   # lint with auto-fix
pnpm test                       # run unit tests with Vitest
pnpm test -- --reporter=verbose # run tests with verbose output
npx vitest run __test__/version.test.ts  # run a single test file
pnpm build                      # compile with @vercel/ncc → dist/index.js
pnpm package                    # copy action.yml + README.md into dist/
```

The `dist/` directory is what gets published — it contains the bundled `index.js` plus `action.yml` and `README.md`. **Never commit generated `dist/` files to the source branch**; they are uploaded as CI artifacts and pushed to the `latest` branch on release.

## Key Conventions

- **Linter:** [Biome](https://biomejs.dev/) — configured in `biome.json`. `dist/`, `__test__/data/`, and `package.json` are excluded. `useLiteralKeys` and `noUselessElse` rules are disabled org-wide.
- **TypeScript:** strict tsconfig, targeting Node 24 (`"node": ">=24.0.0"`).
- **Runtime:** All actions run on `node24` (specified in `action.yml` as `runs.using: node24`).
- **Shared library:** `actions-swing` is the internal helper package used across all setup actions — check there before reimplementing utility logic.
- **Release process:** Releases are automated via [release-please](https://github.com/googleapis/release-please). Merging to `master` triggers release-please; when a release is created, the CI builds `dist/`, pushes it to the `latest` branch, and creates signed `vX` and `vX.Y.Z` tags pointing at `latest`.
- **Conventional commits:** Required for release-please to generate changelogs and bump versions correctly.
