class AgentCommand < Formula
  desc "Sidebar and status tracker for Claude Code sessions in Kitty and Ghostty"
  homepage "https://github.com/brettmostert/homebrew-tap"
  url "https://github.com/brettmostert/homebrew-tap/releases/download/agent-command-v0.31.1/agent-command_0.31.1_darwin_all.tar.gz"
  sha256 "87a4f99d2d9ef46396618ce2b9ca871d02970a7f5f498cc9486c7e45ed582889"
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
