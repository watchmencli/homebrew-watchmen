class Wm < Formula
  desc "Machine and AI governance CLI with an MCP server, zero dependencies"
  homepage "https://trywatchmen.cloud"
  version "2.10.0"
  license "MIT"
  # TH-P0-06 — Versioned, per-platform-pinned URLs.
  # Versioned URLs make the formula content cryptographically pin
  # a specific build. Homebrew caches by URL, so when a new version
  # ships the new formula's URLs break the cache cleanly.
  on_macos do
    on_arm do
      url "https://releases.trywatchmen.cloud/download/community/2.10.0/macos-arm64"
      sha256 "3d294eb39c0f582a6c8f3fae838d1ad8db314eff948304fbec573ec2cd42faf6"
    end
  end
  on_linux do
    on_intel do
      url "https://releases.trywatchmen.cloud/download/community/2.10.0/linux-x86_64"
      sha256 "2196252daa79d0f2f16dc5479cb1be3b58d159d96e03aec4b551e6842191f7e9"
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
