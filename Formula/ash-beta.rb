class AshBeta < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.29.0-beta.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-beta.3/ash-v0.29.0-beta.3-darwin-arm64.tar.gz"
      sha256 "a3858c69dbd899b0131593cd02d20e61b388263965bfbc5b9e4ddc5b29aa569d"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-beta.3/ash-v0.29.0-beta.3-darwin-amd64.tar.gz"
      sha256 "5a52d187fd7d74115a8307f36856f62781b3af34ca9d84b7a6278efecc0e6a17"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-beta.3/ash-v0.29.0-beta.3-linux-arm64.tar.gz"
      sha256 "91a787563567bfa49dafdcfa8137126628139227304b845b9b791af4baf6ded5"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-beta.3/ash-v0.29.0-beta.3-linux-amd64.tar.gz"
      sha256 "47f8bfa158cb620d77159a61ad7732cd4a7c370d16658f5bc484f85182117788"
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
