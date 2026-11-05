class Ash < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.29.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0/ash-v0.29.0-darwin-arm64.tar.gz"
      sha256 "be52302e5b47fb062128de31a780b17f1b49953bf019b7e29ec6c805244eac68"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0/ash-v0.29.0-darwin-amd64.tar.gz"
      sha256 "aa3de5b2c0e7741b2f584b589bd8ff1cc8abe3cbde5e44d05c46ac522f2984ce"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0/ash-v0.29.0-linux-arm64.tar.gz"
      sha256 "d9114e61f55d1a0aa5ff91d6ed070edfbae4de1684bf817ef580ca3ff4b22059"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0/ash-v0.29.0-linux-amd64.tar.gz"
      sha256 "ae3f03d5af45181e8f5edc09dafcb53ec6aa6d49692762858dd13789eeb0dcf4"
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
