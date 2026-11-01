class AgentCommand < Formula
  desc "Sidebar and status tracker for Claude Code sessions in Kitty and Ghostty"
  homepage "https://github.com/brettmostert/homebrew-tap"
  url "https://github.com/brettmostert/homebrew-tap/releases/download/agent-command-v0.25.3/agent-command_0.25.3_darwin_all.tar.gz"
  sha256 "8691da533cc098b6fe41569de67372b2f8560182d3dc133385d870732460fc26"
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
