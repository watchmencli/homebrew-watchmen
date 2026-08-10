class Wm < Formula
  desc "Developer environment intelligence platform — 13 scanners, 24 MCP tools, zero dependencies"
  homepage "https://trywatchmen.cloud"
  version "2.3.2"
  license "MIT"
  # TH-P0-06 — Versioned, per-platform-pinned URLs.
  # Versioned URLs make the formula content cryptographically pin
  # a specific build. Homebrew caches by URL, so when a new version
  # ships the new formula's URLs break the cache cleanly.
  on_macos do
    on_arm do
      url "https://releases.trywatchmen.cloud/download/community/2.3.2/macos-arm64"
      sha256 "46eca24897cace8d4a7b88acfae50735b442722021ff120c8d567ba50d8c7da2"
    end
  end
  on_linux do
    on_intel do
      url "https://releases.trywatchmen.cloud/download/community/2.3.2/linux-x86_64"
      sha256 "dadd753e8055b30e5af0be6f3c320d1239b9c6977934b789ee5d5f38c7630701"
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
