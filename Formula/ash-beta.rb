class AshBeta < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.29.0-beta.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-beta.4/ash-v0.29.0-beta.4-darwin-arm64.tar.gz"
      sha256 "a8ec2afc62f17e6e155e06d105e24c0a96372ed4aadbd8c9a0684fc387c1828c"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-beta.4/ash-v0.29.0-beta.4-darwin-amd64.tar.gz"
      sha256 "1ea7c85b5b2635aaeac73b6e2cc25659f02273f80d9f8b28e28afd98c1da2e6a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-beta.4/ash-v0.29.0-beta.4-linux-arm64.tar.gz"
      sha256 "9058032579405965590c94246899f29eaae2471941ded512ff393c287180bfff"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-beta.4/ash-v0.29.0-beta.4-linux-amd64.tar.gz"
      sha256 "4585d0300406f19bf2da5aac504240c7a0e8b56bf092957d8597789f972ca8d7"
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
