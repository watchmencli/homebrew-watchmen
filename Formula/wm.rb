class Wm < Formula
  desc "Machine and AI governance CLI with an MCP server, zero dependencies"
  homepage "https://trywatchmen.cloud"
  version "3.2.4"
  license "MIT"
  # Versioned, per-platform-pinned URLs.
  # Versioned URLs make the formula content cryptographically pin
  # a specific build. Homebrew caches by URL, so when a new version
  # ships the new formula's URLs break the cache cleanly.
  on_macos do
    on_arm do
      url "https://releases.trywatchmen.cloud/download/community/3.2.4/macos-arm64"
      sha256 "d1b9a184f05eaf62350d532d6492c5a5345215a89fc3a15b69892645db2d588c"
    end
  end
  on_linux do
    on_intel do
      url "https://releases.trywatchmen.cloud/download/community/3.2.4/linux-x86_64"
      sha256 "851100642c30fa29b32fc5016c38477d119714aed1be399c55b95c5c78e3244c"
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
