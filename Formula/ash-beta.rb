class AshBeta < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.27.0-beta.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-beta.2/ash-v0.27.0-beta.2-darwin-arm64.tar.gz"
      sha256 "4bcf199a53c9d27d9a1c5e5ff50a5dceaf9d2e130e6c79efe6d8a5fbe980e809"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-beta.2/ash-v0.27.0-beta.2-darwin-amd64.tar.gz"
      sha256 "0d50f5248a50b58761454cdc55e8b4e09d89ac6e71fe795930957e10691c1db9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-beta.2/ash-v0.27.0-beta.2-linux-arm64.tar.gz"
      sha256 "80866b0eb45997ed196d03fbcda5fe749457f1a11076208704eb84c747c47da1"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-beta.2/ash-v0.27.0-beta.2-linux-amd64.tar.gz"
      sha256 "23885af4d6b884cc7e006ae0f8fc3826936f400e6ae87215954c27fa0b91c383"
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
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ash version")
  end
end
