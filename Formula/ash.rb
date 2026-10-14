class Ash < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.28.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.28.0/ash-v0.28.0-darwin-arm64.tar.gz"
      sha256 "09b8383283644c5e1092c00d0844dc74a7730647da9f213829b8db5c1b83ba34"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.28.0/ash-v0.28.0-darwin-amd64.tar.gz"
      sha256 "8a96d199eb7bc03db63d4926cbcc5e7d3809d58a825bf0bdc8523b60efbda8eb"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.28.0/ash-v0.28.0-linux-arm64.tar.gz"
      sha256 "6debc4e0711fe8caaec1de37eb98e76cf73e7496fb31b161bf5a852dea3ed908"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.28.0/ash-v0.28.0-linux-amd64.tar.gz"
      sha256 "484923d0fe358009d47d501bf7a7a966064a2798b9b0986a096eb2e9371e19ba"
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
