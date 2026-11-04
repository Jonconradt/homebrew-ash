class AshBeta < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.29.0-beta.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-beta.5/ash-v0.29.0-beta.5-darwin-arm64.tar.gz"
      sha256 "064514a29958f72d3551a6244aa13d058dc13f22915ec3c9954fa65115bfbb7f"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-beta.5/ash-v0.29.0-beta.5-darwin-amd64.tar.gz"
      sha256 "55a7429aa98aecf65cdb0b879a9d44a499bbb7f29151d30973db3a78f7e2c58e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-beta.5/ash-v0.29.0-beta.5-linux-arm64.tar.gz"
      sha256 "997f08cf933bc05c3dc117261ca54540ecc7542bcd1d95164519a00e877d3134"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-beta.5/ash-v0.29.0-beta.5-linux-amd64.tar.gz"
      sha256 "e1f8f8ba2620c01eca786dcc5f48f91015299368fa7ae7ce6ee435f06fe43695"
    end
  end

  def install
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "amd64"
    bin.install "ash-v#{version}-#{os}-#{arch}" => "ash"
    bin.install "ash-broker"
    (lib / "ash").install "plugins"
    man1.install "usr/share/man/man1/ash.1"
    Dir["usr/share/man/*/man1/ash.1"].each do |page|
      locale = File.basename(File.dirname(File.dirname(page)))
      (share / "man" / locale / "man1").install page
    end
    (share / "licenses" / "ash").install "LICENSE"
    (share / "licenses" / "ash").install "THIRD_PARTY_NOTICES.md"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ash version")
  end
end
