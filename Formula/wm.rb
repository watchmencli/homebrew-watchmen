class Wm < Formula
  desc "Machine and AI governance CLI with an MCP server, zero dependencies"
  homepage "https://trywatchmen.cloud"
  version "2.8.10"
  license "MIT"
  # TH-P0-06 — Versioned, per-platform-pinned URLs.
  # Versioned URLs make the formula content cryptographically pin
  # a specific build. Homebrew caches by URL, so when a new version
  # ships the new formula's URLs break the cache cleanly.
  on_macos do
    on_arm do
      url "https://releases.trywatchmen.cloud/download/community/2.8.10/macos-arm64"
      sha256 "f23c98cab54e6e8bc80bdae25b98bed20211332aa19c316bda12fbb676dec361"
    end
  end
  on_linux do
    on_intel do
      url "https://releases.trywatchmen.cloud/download/community/2.8.10/linux-x86_64"
      sha256 "3ea8c0cf77682dc2e5d3e049f8316e89cd6d4c3311a1828f815fc99c6147b3c1"
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
