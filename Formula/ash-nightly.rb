class AshNightly < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.27.0-nightly.20261011.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-nightly.20261011.1/ash-v0.27.0-nightly.20261011.1-darwin-arm64.tar.gz"
      sha256 "efbfa88cbb64b5dc6062934bb0f99d06da6820a1550726f8b9839d296c97910c"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-nightly.20261011.1/ash-v0.27.0-nightly.20261011.1-darwin-amd64.tar.gz"
      sha256 "25ba801e470a421457bee7fd7a1feab7b2916b1af19cc7c30b990b17999e37d7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-nightly.20261011.1/ash-v0.27.0-nightly.20261011.1-linux-arm64.tar.gz"
      sha256 "b4b081733afe6671e016da1df755d9a71415b77b32c32e0504568ccc3b71ce7f"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-nightly.20261011.1/ash-v0.27.0-nightly.20261011.1-linux-amd64.tar.gz"
      sha256 "8ff600b86e2551112c6b2e22504a4c93319599532328890da20381d40586f920"
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
