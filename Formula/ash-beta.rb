class AshBeta < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.28.0-beta.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.28.0-beta.1/ash-v0.28.0-beta.1-darwin-arm64.tar.gz"
      sha256 "d8f8121cb4a4b4d03d9978122e1983ded7f6d332e351bb7f4b3c4ea5a4a71bed"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.28.0-beta.1/ash-v0.28.0-beta.1-darwin-amd64.tar.gz"
      sha256 "95a595f748736a1f72de3966a2241ae3bcfaf370d1d734007a7ea7ae05051aea"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.28.0-beta.1/ash-v0.28.0-beta.1-linux-arm64.tar.gz"
      sha256 "1c527c408ea579df3f21557637ad14251a79f596493ac2231b563a06115046bf"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.28.0-beta.1/ash-v0.28.0-beta.1-linux-amd64.tar.gz"
      sha256 "bd2bb10aba3c1b8728edbab2b2d31e54dfb92196e5d05802c50f4eaadd57104d"
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
