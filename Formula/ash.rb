class Ash < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.31.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.31.0/ash-v0.31.0-darwin-arm64.tar.gz"
      sha256 "02264feb5b0145689488b5d5d6eff6cec4eeda78266f6286dd8a45a0323737a6"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.31.0/ash-v0.31.0-darwin-amd64.tar.gz"
      sha256 "ea5861750e83db6cb66b7fbbd586f7c3397a8a72524eed89442555f289c057b8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.31.0/ash-v0.31.0-linux-arm64.tar.gz"
      sha256 "b48c4db337ff93e9eb01bfce8806d97f4860361081bc8cf76f9a562480079dbf"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.31.0/ash-v0.31.0-linux-amd64.tar.gz"
      sha256 "6fe81c2f9c5fb4e589ecec2b509c118a5cbcde7d7aeff11c6b520a89bc153561"
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
