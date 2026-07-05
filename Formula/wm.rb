class Wm < Formula
  desc "Developer environment intelligence platform — 13 scanners, 24 MCP tools, zero dependencies"
  homepage "https://trywatchmen.cloud"
  version "1.8.6"
  license "MIT"
  # TH-P0-06 — Versioned, per-platform-pinned URLs.
  # Versioned URLs make the formula content cryptographically pin
  # a specific build. Homebrew caches by URL, so when a new version
  # ships the new formula's URLs break the cache cleanly.
  on_macos do
    on_arm do
      url "https://releases.trywatchmen.cloud/download/community/1.8.6/macos-arm64"
      sha256 "0b49d8e9c0a7e4ce63b3a48db016af1dd38c7a2a4f577a5a49f4340a21c3bec7"
    end
  end
  on_linux do
    on_intel do
      url "https://releases.trywatchmen.cloud/download/community/1.8.6/linux-x86_64"
      sha256 "24b6ae39bb2df18930e21209009db4d9ee2c21df8d0e4924d1353fc3f167bfce"
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
