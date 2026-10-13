class AshBeta < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.27.0-beta.4"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-beta.4/ash-v0.27.0-beta.4-darwin-arm64.tar.gz"
      sha256 "947939a96d25fda18830b14bf9784b024b5f5173954437a0c07331c2a0176016"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-beta.4/ash-v0.27.0-beta.4-darwin-amd64.tar.gz"
      sha256 "12e8bf08ea31896766585a29bea924b16e8ed6240d67e8dd8cf16d5087c0f4da"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-beta.4/ash-v0.27.0-beta.4-linux-arm64.tar.gz"
      sha256 "5ccf9a580fde7731e43c65e7ec7877fe3c80a7fc3d487a35c1f4d055183c2cf5"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-beta.4/ash-v0.27.0-beta.4-linux-amd64.tar.gz"
      sha256 "8a4e8e2edef616b514a224dc5bbe26438afe11a44322caae77a10a3dd4e4db60"
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
