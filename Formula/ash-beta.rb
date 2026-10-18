class AshBeta < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.29.0-beta.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-beta.1/ash-v0.29.0-beta.1-darwin-arm64.tar.gz"
      sha256 "b460964cf7fab0aed869fe3c74c15bd5aad3263c6a1abc311ba1ecfe28455814"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-beta.1/ash-v0.29.0-beta.1-darwin-amd64.tar.gz"
      sha256 "3b92dff249888c50c408e1e0dc0bb3d646aad95cab514512221215aafc1f1fb1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-beta.1/ash-v0.29.0-beta.1-linux-arm64.tar.gz"
      sha256 "404b4038b9e985be1c01835ce8a856058a6ac15aa5e9b7f04b797220d5181588"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-beta.1/ash-v0.29.0-beta.1-linux-amd64.tar.gz"
      sha256 "8e500adb278b85ce276081d13152a9e010b0226b8cb7df3e027651d411519b46"
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
