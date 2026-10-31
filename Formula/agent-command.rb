class AgentCommand < Formula
  desc "Sidebar and status tracker for Claude Code sessions in Kitty and Ghostty"
  homepage "https://github.com/brettmostert/homebrew-tap"
  url "https://github.com/brettmostert/homebrew-tap/releases/download/agent-command-v0.3.0/agent-command_0.3.0_darwin_all.tar.gz"
  sha256 "9592c948b57ee7b959ade038f2050b9844b6a93f51209c37d2de67a2f0253dda"
  license "MIT"

  depends_on :macos

  def install
    bin.install "agent-command"
    bin.install_symlink "agent-command" => "acmd"
    generate_completions_from_executable(bin/"agent-command", "completion")
  end

  def caveats
    <<~EOS
      Run `acmd init` (or any acmd command) to set up Kitty/Ghostty and Claude Code hooks.
      Before `brew uninstall agent-command`, run `acmd uninstall` to remove those config changes.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/agent-command version")
    assert_match version.to_s, shell_output("#{bin}/acmd version")
  end
end
