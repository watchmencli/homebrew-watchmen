class Wm < Formula
  desc "Developer environment intelligence platform — 13 scanners, 24 MCP tools, zero dependencies"
  homepage "https://trywatchmen.cloud"
  version "2.2.4"
  license "MIT"
  # TH-P0-06 — Versioned, per-platform-pinned URLs.
  # Versioned URLs make the formula content cryptographically pin
  # a specific build. Homebrew caches by URL, so when a new version
  # ships the new formula's URLs break the cache cleanly.
  on_macos do
    on_arm do
      url "https://releases.trywatchmen.cloud/download/community/2.2.4/macos-arm64"
      sha256 "6ede5a5b7afbe197eafd4bc1d85000cc236397d31a44f3d4d395116fef85ecf7"
    end
  end
  on_linux do
    on_intel do
      url "https://releases.trywatchmen.cloud/download/community/2.2.4/linux-x86_64"
      sha256 "2ead205e5196f731de1ad773c48491c4d048f22c2208478c474eec55783e3658"
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
