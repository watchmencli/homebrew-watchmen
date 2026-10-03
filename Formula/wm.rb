class Wm < Formula
  desc "Machine and AI governance CLI with an MCP server, zero dependencies"
  homepage "https://trywatchmen.cloud"
  version "2.7.10"
  license "MIT"
  # TH-P0-06 — Versioned, per-platform-pinned URLs.
  # Versioned URLs make the formula content cryptographically pin
  # a specific build. Homebrew caches by URL, so when a new version
  # ships the new formula's URLs break the cache cleanly.
  on_macos do
    on_arm do
      url "https://releases.trywatchmen.cloud/download/community/2.7.10/macos-arm64"
      sha256 "c61525814e53e725af9b897c434ea81ecd4ac2e9db4d63c701471021013bc45d"
    end
  end
  on_linux do
    on_intel do
      url "https://releases.trywatchmen.cloud/download/community/2.7.10/linux-x86_64"
      sha256 "b70714cba4ff3ef05cbdd8501bc4711a8f7e4415c850135e560dd3b7278d7081"
    end
  end
  def install
    # Homebrew stages the redirected S3 object basename, not the public URL
    # basename, so install the actual staged filename per platform.
    on_macos do
      bin.install "wm-community-macos-arm64" => "wm"
    end
    on_linux do
      bin.install "wm-community-linux-x86_64" => "wm"
    end
  end
  test do
    assert_match "WatchmenCLI Community", shell_output("#{bin}/wm version")
  end
end
