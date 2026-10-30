# brettmostert/tap

Homebrew formulas for tools by [@brettmostert](https://github.com/brettmostert), all for macOS.

## Install

```sh
brew install brettmostert/tap/<formula>
```

Installing by the full name, as above, trusts that formula automatically ([Homebrew Tap Trust](https://docs.brew.sh/Tap-Trust)). If you `brew tap brettmostert/tap` first and then install by short name, trust the formula once:

```sh
brew trust --formula brettmostert/tap/<formula>
```

Upgrade with `brew upgrade <formula>`.

## Formulas

| Formula | Description | Install |
|---|---|---|
| [`agent-command`](Formula/agent-command.rb) | Sidebar and status tracker for Claude Code sessions in Kitty and Ghostty. Installs `agent-command` and the alias `acmd`. | `brew install brettmostert/tap/agent-command` |

## How releases get here

Each tool's release pipeline publishes here automatically. Don't edit formulas by hand: the next release overwrites them.

- **Release assets** live in this repo's [Releases](https://github.com/brettmostert/homebrew-tap/releases), tagged `<formula>-vX.Y.Z` (e.g. `agent-command-v0.1.1`) so several tools can share the tap. Each release has macOS archives (`darwin_arm64`, `darwin_amd64`, and `darwin_all` universal), `checksums.txt` (SHA-256) and SBOMs.
- **Formulas** in [`Formula/`](Formula) are committed by the `brettmostert-release[bot]` GitHub App, but only after the formula has been installed, tested (`brew test`) and audited (`brew audit --strict --online`) against the published release.

## Manual download

Browsers quarantine downloaded binaries, so verify and clear the flag after extracting:

```sh
shasum -a 256 -c checksums.txt --ignore-missing
tar -xzf <formula>_<version>_darwin_all.tar.gz
xattr -d com.apple.quarantine <binary>
```

Homebrew installs aren't quarantined.

## License

[MIT](LICENSE)
