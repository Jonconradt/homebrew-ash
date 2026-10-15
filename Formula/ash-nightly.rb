class AshNightly < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.29.0-nightly.20261015"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-nightly.20261015/ash-v0.29.0-nightly.20261015-darwin-arm64.tar.gz"
      sha256 "3776f22ad58daf5d84dbff48889828114942f7cea8870e7f9cfff2b86c35d3b6"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-nightly.20261015/ash-v0.29.0-nightly.20261015-darwin-amd64.tar.gz"
      sha256 "17c6ee04097c6a9ad5938868582cf15990911526846b1795fcbd1c9af7c8629b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-nightly.20261015/ash-v0.29.0-nightly.20261015-linux-arm64.tar.gz"
      sha256 "144d866e96b619aa3982317cae799a986d3aa3b1fe8db81cf9276e9b4784ba1b"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-nightly.20261015/ash-v0.29.0-nightly.20261015-linux-amd64.tar.gz"
      sha256 "47618becfb895246e1349f286574d11ca2fd15786fa52417638dfc53cfd9b208"
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
