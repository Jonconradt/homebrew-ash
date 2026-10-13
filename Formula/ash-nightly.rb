class AshNightly < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.27.0-nightly.20261013"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-nightly.20261013/ash-v0.27.0-nightly.20261013-darwin-arm64.tar.gz"
      sha256 "a9506381a1833cc1c517057f4cd5bfd420cea25c33739c821d0e54c697a14eeb"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-nightly.20261013/ash-v0.27.0-nightly.20261013-darwin-amd64.tar.gz"
      sha256 "5c82474c73688bfcd8afdeccf9214b57edeba25ad39410536ffe806038ab9e70"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-nightly.20261013/ash-v0.27.0-nightly.20261013-linux-arm64.tar.gz"
      sha256 "96b3389d60eb296bde308ede9a2f3a90147af8646367fb54df3912587b1b9eb0"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-nightly.20261013/ash-v0.27.0-nightly.20261013-linux-amd64.tar.gz"
      sha256 "d4ae44dbfe416e82cc3f14f02c3c71eb07f5fdd736df9a0f1eee94a1949ae22a"
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
