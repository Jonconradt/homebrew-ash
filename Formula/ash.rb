class Ash < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.30.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.30.0/ash-v0.30.0-darwin-arm64.tar.gz"
      sha256 "e727312954e8b000a5955b21f3df2e908a489d90097fced43d83596a835cece2"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.30.0/ash-v0.30.0-darwin-amd64.tar.gz"
      sha256 "e82a0584751717a4ea3021dc69134385b55826806bf4e6b195cfd8961e40ad19"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.30.0/ash-v0.30.0-linux-arm64.tar.gz"
      sha256 "581b5deaed732aed2a5e0b29bb4f6e1e5c7c86d26ddf49e010b7126c8507d702"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.30.0/ash-v0.30.0-linux-amd64.tar.gz"
      sha256 "cbc587d3c780844e0167c78d36683cd1a2a23b821256e2e9938d2d424b679ce9"
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
