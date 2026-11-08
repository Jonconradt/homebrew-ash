class Ash < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.30.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.30.1/ash-v0.30.1-darwin-arm64.tar.gz"
      sha256 "21e82e6452c69c1c8646bcaeab2614547cff42875a9105b57670a0b0b6519fba"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.30.1/ash-v0.30.1-darwin-amd64.tar.gz"
      sha256 "d7ec5559b615ee1d2e334992601b6805d66c7db77bec69001153131571c7fd58"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.30.1/ash-v0.30.1-linux-arm64.tar.gz"
      sha256 "06bfda4dbf900ec0e5f862e9b1609e9b55309af01a423460596d0c608e4d3ba6"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.30.1/ash-v0.30.1-linux-amd64.tar.gz"
      sha256 "512306f5e7f8eab4d76389735e7673bc7c9a4b36735cc48ffb446dfa59f02037"
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
