class Ash < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.32.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.32.0/ash-v0.32.0-darwin-arm64.tar.gz"
      sha256 "49d1339b66311c5c2a828cfb72380ae2a62d967dd9844e3d1677b925d77c154f"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.32.0/ash-v0.32.0-darwin-amd64.tar.gz"
      sha256 "dee9607741a872d74f502a47cf7cb05bd05cf7311849d3be1e80e40cc6d58ae1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.32.0/ash-v0.32.0-linux-arm64.tar.gz"
      sha256 "9397ecfe0d5f6997ef10b455c7d2cb9d3c3c073a887d762287e41a17808ab870"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.32.0/ash-v0.32.0-linux-amd64.tar.gz"
      sha256 "79cc84c6d9d019c9eb312393b62315c782728728acaec9ee8b1b735f25ac9627"
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
