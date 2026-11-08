class AshBeta < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.30.0-beta.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.30.0-beta.1/ash-v0.30.0-beta.1-darwin-arm64.tar.gz"
      sha256 "2af102479003fad5ada6d1cb86897ba7302b6108ddcbfc312a1fd29daa81b342"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.30.0-beta.1/ash-v0.30.0-beta.1-darwin-amd64.tar.gz"
      sha256 "5da0303950da4cbae1aa62d9648e03e3ff0fa2761195a8e5dc9895a0e0866b0d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.30.0-beta.1/ash-v0.30.0-beta.1-linux-arm64.tar.gz"
      sha256 "6e83b1ffdd83d525f4bfbedff2be8a836eef4f22f7eb95f339b9b6e6f6be227a"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.30.0-beta.1/ash-v0.30.0-beta.1-linux-amd64.tar.gz"
      sha256 "b58267389687bc22eb27f84afb0e7e938760c992364069e9f00ebb927317fdd2"
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
