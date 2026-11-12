class AshBeta < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.32.0-beta.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.32.0-beta.2/ash-v0.32.0-beta.2-darwin-arm64.tar.gz"
      sha256 "ed370bf12067a22c1add797085736c23d5f95f85bfdd530feeb932499e0e6521"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.32.0-beta.2/ash-v0.32.0-beta.2-darwin-amd64.tar.gz"
      sha256 "31c768ffe9f39ce5008464205559fb2d6e208dc46a1ac64f846ea074c0331081"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.32.0-beta.2/ash-v0.32.0-beta.2-linux-arm64.tar.gz"
      sha256 "cbb4ccc1fe2018c6b0c953ec57d1350d4e2d1a89b475a9a58939bfa865dd2966"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.32.0-beta.2/ash-v0.32.0-beta.2-linux-amd64.tar.gz"
      sha256 "f7fc8f01069a5e4dee49d62b99bfa5db429a4655a7323cc76e52285e1656b4f4"
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
