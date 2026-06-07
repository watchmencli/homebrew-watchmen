class Wm < Formula
  desc "On-device developer environment intelligence — scanners, retrieval, MCP, signed releases"
  homepage "https://trywatchmen.cloud"
  version "1.6.7"
  license "MIT"
  # Versioned, per-platform-pinned URLs.
  # Versioned URLs make the formula content cryptographically pin
  # a specific build. Homebrew caches by URL, so when a new version
  # ships the new formula's URLs break the cache cleanly.
  on_macos do
    on_arm do
      url "https://releases.trywatchmen.cloud/download/community/1.6.7/macos-arm64"
      sha256 "144740353c49495252b797a415c3be355ea9dbe3e3071d552fca43a6ae524820"
    end
  end
  on_linux do
    on_intel do
      url "https://releases.trywatchmen.cloud/download/community/1.6.7/linux-x86_64"
      sha256 "394d35e87ce056402892eaf7ba33beceb17fdad2afe91947d771a5b6483f7d51"
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
