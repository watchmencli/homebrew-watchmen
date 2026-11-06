class Wm < Formula
  desc "Machine and AI governance CLI with an MCP server, zero dependencies"
  homepage "https://trywatchmen.cloud"
  version "3.1.3"
  license "MIT"
  # Versioned, per-platform-pinned URLs.
  # Versioned URLs make the formula content cryptographically pin
  # a specific build. Homebrew caches by URL, so when a new version
  # ships the new formula's URLs break the cache cleanly.
  on_macos do
    on_arm do
      url "https://releases.trywatchmen.cloud/download/community/3.1.3/macos-arm64"
      sha256 "44a7167c1e5fb5494841662bd760ccbc3f73752367d93f90273186e797c7acf0"
    end
  end
  on_linux do
    on_intel do
      url "https://releases.trywatchmen.cloud/download/community/3.1.3/linux-x86_64"
      sha256 "b953c6c441d057eb401be4d8f4a2dd51fb69edd9315c306b188d0eb2bc3d5aea"
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
  def caveats
    <<~EOS
      wm keeps its data in ~/.watchmen (scan history, the document index, keys).
      Before `brew uninstall`, run `wm uninstall` to remove its background service;
      `wm uninstall --purge` also deletes ~/.watchmen.
    EOS
  end

  test do
    assert_match "WatchmenCLI Community", shell_output("#{bin}/wm version")
  end
end
