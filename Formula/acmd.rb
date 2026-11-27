class Acmd < Formula
  desc "Run AI coding agents and terminals as sessions you reach from any machine"
  homepage "https://github.com/brettmostert/homebrew-tap"
  version "0.96.0"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :tahoe

    on_arm do
      url "https://github.com/brettmostert/homebrew-tap/releases/download/agent-command-v#{version}/acmd-#{version}-darwin-arm64.tar.gz"
      sha256 "f57c1d6289eea7773255e657e834472855476458d7f43da676bbf3dbc7061a21"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/brettmostert/homebrew-tap/releases/download/agent-command-v#{version}/acmd-#{version}-linux-arm64.tar.gz"
      sha256 "4f40f5167748c3c98e29497537d90429cb47adb2f55e754b78057a3f4f790390"
    end
    on_intel do
      url "https://github.com/brettmostert/homebrew-tap/releases/download/agent-command-v#{version}/acmd-#{version}-linux-amd64.tar.gz"
      sha256 "dcfc4c7f58d78a6f146a84dadda396ca2072d4f99b49317abfc18d7c3a55ec8a"
    end
  end

  # Upgrading from the app's cask from before it used this formula: the old
  # cask linked these to the acmd inside the app.
  link_overwrite "bin/acmd", "bin/agent-command"

  def install
    bin.install "bin/acmd", "bin/agent-command"
    # The speech engine, which acmd finds in ../libexec. MLX looks for its
    # shaders next to it.
    libexec.install "libexec/acmd-speech", "libexec/mlx.metallib" if OS.mac?
  end

  # acmd init writes in your home folder, which Homebrew's sandbox allows only
  # for the folders named here. If it fails anyway, the caveats say to run it.
  post_install_steps do
    run "bin/acmd", args: ["init"], base: :opt_prefix, must_succeed: false, print_stderr: false,
        writable_paths: [".claude", ".config", ".local/state", ".gemini", "Library/LaunchAgents"],
        writable_base: :home
  end

  def caveats
    <<~EOS
      If `acmd doctor` says acmd isn't set up, run:
        acmd init
      It adds the Claude Code hooks, saves your login shell's environment and
      installs the service that runs acmd's daemon: from boot on Linux and WSL2,
      from login on macOS. It's safe to run again. WSL2 needs systemd turned on
      for the service ([boot] systemd=true in /etc/wsl.conf).

      Upgrades need nothing more: within a minute the daemon restarts on the
      new version by itself, and sessions keep running.

      Before `brew uninstall acmd`, run `acmd uninstall`: it ends sessions,
      removes the service and the hooks.
    EOS
  end

  test do
    assert_match "agent-command #{version}", shell_output("#{bin}/acmd version")
  end
end
