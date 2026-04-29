# virtual-monorepo

A virtual monorepo for [browser-actions](https://github.com/browser-actions). Managing distributed repositories with the convenience of a single codebase.

## Setup

Clone all org repositories and create symlinks under `workspaces/`:

```sh
./setup.sh
```

Each repo is cloned as a sibling directory (e.g., `../setup-chrome`) and symlinked into `workspaces/` for unified access. The `workspaces/` directory is gitignored.

## Repositories

| Repository | Description |
|---|---|
| [actions-swing](https://github.com/browser-actions/actions-swing) | Shared helper library used by the setup-* actions |
| [setup-chrome](https://github.com/browser-actions/setup-chrome) | Install Chrome/Chromium |
| [setup-firefox](https://github.com/browser-actions/setup-firefox) | Install Firefox |
| [setup-edge](https://github.com/browser-actions/setup-edge) | Install Microsoft Edge |
| [setup-geckodriver](https://github.com/browser-actions/setup-geckodriver) | Install geckodriver |
| [release-chrome-extension](https://github.com/browser-actions/release-chrome-extension) | Publish a Chrome extension to the Web Store |
| [release-firefox-addon](https://github.com/browser-actions/release-firefox-addon) | Publish a Firefox addon to AMO |
