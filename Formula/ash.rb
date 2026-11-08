class Ash < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.30.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.30.2/ash-v0.30.2-darwin-arm64.tar.gz"
      sha256 "0c1e71cd60778037ba787c8a9a141c6bbcaad1d5db23c6bf553f06b3240632cb"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.30.2/ash-v0.30.2-darwin-amd64.tar.gz"
      sha256 "a9ef6f99fe57f79b510f9cdc0105de8c3abf863a1798db4a7be1189a04222eab"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.30.2/ash-v0.30.2-linux-arm64.tar.gz"
      sha256 "7355faa8a0aca54480ccc35aaef79e90824158c071b526bc57f612e06aedd38a"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.30.2/ash-v0.30.2-linux-amd64.tar.gz"
      sha256 "16bafd56682d59d290a85fa952af9484f982ddd2bcd5d467ba25a004e0394ce2"
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
