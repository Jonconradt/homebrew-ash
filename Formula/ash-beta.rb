class AshBeta < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.33.0-beta.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.33.0-beta.1/ash-v0.33.0-beta.1-darwin-arm64.tar.gz"
      sha256 "a0ea78715e3aae2b915a36c74a2472c0f13d52cc70315b728e879f88730bf8dc"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.33.0-beta.1/ash-v0.33.0-beta.1-darwin-amd64.tar.gz"
      sha256 "27620c4bbb37f058a37ec96d8b049fc8f5027cf813691c1b42bdcbcd36e74787"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.33.0-beta.1/ash-v0.33.0-beta.1-linux-arm64.tar.gz"
      sha256 "a16c7706d2bf19c58d2b79870457efc6129c34d378d743bcbf29c7a43c3b18a6"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.33.0-beta.1/ash-v0.33.0-beta.1-linux-amd64.tar.gz"
      sha256 "ca6f720071a3489a936a79ce30cc1d250e9d1fb0f0ae3d9f2cb07c8aef6c8b60"
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
