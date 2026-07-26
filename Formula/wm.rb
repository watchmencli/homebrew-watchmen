class Wm < Formula
  desc "Developer environment intelligence platform — 13 scanners, 24 MCP tools, zero dependencies"
  homepage "https://trywatchmen.cloud"
  version "2.2.8"
  license "MIT"
  # TH-P0-06 — Versioned, per-platform-pinned URLs.
  # Versioned URLs make the formula content cryptographically pin
  # a specific build. Homebrew caches by URL, so when a new version
  # ships the new formula's URLs break the cache cleanly.
  on_macos do
    on_arm do
      url "https://releases.trywatchmen.cloud/download/community/2.2.8/macos-arm64"
      sha256 "d969ddc6c6992bb14d66517e537e42b8202a20d547bf47e064547713908e000b"
    end
  end
  on_linux do
    on_intel do
      url "https://releases.trywatchmen.cloud/download/community/2.2.8/linux-x86_64"
      sha256 "8a964230424fb4842e855bb1b8e03350a3ea5ae47bfcb1999828669f9060c58d"
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
