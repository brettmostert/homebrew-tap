class Acmd < Formula
  desc "Run AI coding agents and terminals as sessions you reach from any machine"
  homepage "https://github.com/brettmostert/homebrew-tap"
  version "0.97.0"
  license "MIT"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :tahoe

    on_arm do
      url "https://github.com/brettmostert/homebrew-tap/releases/download/agent-command-v#{version}/acmd-#{version}-darwin-arm64.tar.gz"
      sha256 "1d369126b45b3cd6ec35395827fa14a9e68fd9fb5e6e04f9594412802459975d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/brettmostert/homebrew-tap/releases/download/agent-command-v#{version}/acmd-#{version}-linux-arm64.tar.gz"
      sha256 "8b605197daa5c3073c283b1ddb02de997fd54e593bc565fbe46e0bc02f2a17ea"
    end
    on_intel do
      url "https://github.com/brettmostert/homebrew-tap/releases/download/agent-command-v#{version}/acmd-#{version}-linux-amd64.tar.gz"
      sha256 "a4e1086fc436344d069212f9f1549224f0c91c330ca1e7c1c793779fc72c0cf3"
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
