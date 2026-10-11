class AshNightly < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.27.0-nightly.20261011.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-nightly.20261011.2/ash-v0.27.0-nightly.20261011.2-darwin-arm64.tar.gz"
      sha256 "911e7fd88c5657c78fb678a579696c87bd185fa8aa5dedd11bb1db65e6adf1e3"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-nightly.20261011.2/ash-v0.27.0-nightly.20261011.2-darwin-amd64.tar.gz"
      sha256 "79bc438da14901bb2c9db6c1f932f94b81c0b0b7fcd383983ea4d2fbdd386f73"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-nightly.20261011.2/ash-v0.27.0-nightly.20261011.2-linux-arm64.tar.gz"
      sha256 "5ff840f501be4feb114d2554a964334c8b78a62bb9439a15e43e2a8e586f328e"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-nightly.20261011.2/ash-v0.27.0-nightly.20261011.2-linux-amd64.tar.gz"
      sha256 "80f92be25849ff40c3db8b13adf56d76afbcc5576130917fcb1d5c81c84ba73c"
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
