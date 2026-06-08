class Wm < Formula
  desc "On-device developer environment intelligence — scanners, retrieval, MCP, signed releases"
  homepage "https://trywatchmen.cloud"
  version "1.6.8"
  license "MIT"
  # Versioned, per-platform-pinned URLs.
  # Versioned URLs make the formula content cryptographically pin
  # a specific build. Homebrew caches by URL, so when a new version
  # ships the new formula's URLs break the cache cleanly.
  on_macos do
    on_arm do
      url "https://releases.trywatchmen.cloud/download/community/1.6.8/macos-arm64"
      sha256 "41adecf4f5250e93e205adafb678284bd2582b152eefd061842dd3975c21b8ef"
    end
  end
  on_linux do
    on_intel do
      url "https://releases.trywatchmen.cloud/download/community/1.6.8/linux-x86_64"
      sha256 "06935f97396ff3cc019894ad0e69532218affd6cd2b81a2b42c8c9261a7b4db9"
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
      Verify this build with Sigstore (cosign keyless + Rekor transparency log):

        wm verify-self

      The `wm verify-self` subcommand fetches the cosign bundle from
      releases.trywatchmen.cloud and runs `cosign verify-blob` inline
      when cosign is on PATH. Use `wm verify-self --offline` to print
      the canonical recipe without touching the network.

      The cosign bundles live at:
        https://releases.trywatchmen.cloud/download/community/<version>/<platform>.cosign.bundle

      See https://trywatchmen.cloud/trust for the full trust posture.
    EOS
  end

  test do
    assert_match "WatchmenCLI Community", shell_output("#{bin}/wm version")
  end
end
