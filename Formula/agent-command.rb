class AgentCommand < Formula
  desc "Sidebar and status tracker for Claude Code sessions in Kitty and Ghostty"
  homepage "https://github.com/brettmostert/homebrew-tap"
  url "https://github.com/brettmostert/homebrew-tap/releases/download/agent-command-v0.33.0/agent-command_0.33.0_darwin_all.tar.gz"
  sha256 "fc27a67c67fc649d28d09d9975991049c0aaf23d195a580d53ce8e9b127d41d2"
  license "MIT"

  depends_on :macos

  def install
    bin.install "agent-command"
    bin.install_symlink "agent-command" => "acmd"
    # the Swift speech engine (acmd finds it in ../libexec)
    libexec.install "acmd-speech"
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
    assert_match "acmd-speech", shell_output("#{libexec}/acmd-speech --version")
  end
end
