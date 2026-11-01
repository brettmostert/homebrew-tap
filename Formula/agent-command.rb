class AgentCommand < Formula
  desc "Sidebar and status tracker for Claude Code sessions in Kitty and Ghostty"
  homepage "https://github.com/brettmostert/homebrew-tap"
  url "https://github.com/brettmostert/homebrew-tap/releases/download/agent-command-v0.25.2/agent-command_0.25.2_darwin_all.tar.gz"
  sha256 "f3591967a47df181c1e877dd0cebce530bc21bc6689480c5d48a4ca503ae6864"
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
