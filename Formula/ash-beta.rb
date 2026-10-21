class AshBeta < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.29.0-beta.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-beta.2/ash-v0.29.0-beta.2-darwin-arm64.tar.gz"
      sha256 "d098e798ba6c41e2401644a773bdda23d9202351be808ab64a962b452b5fe179"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-beta.2/ash-v0.29.0-beta.2-darwin-amd64.tar.gz"
      sha256 "d25c6985aee09efa458208e166b2bb7612c4f8cd25e2d9b1cdae732404bb4f0c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-beta.2/ash-v0.29.0-beta.2-linux-arm64.tar.gz"
      sha256 "d57c3cbb47fe69d8b45e5e9b01711cf075249f0e22d77f6133f9bbea8b3a3849"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.29.0-beta.2/ash-v0.29.0-beta.2-linux-amd64.tar.gz"
      sha256 "2cac038f8f9f524c6dd36124ee5ce41a26a15fa8e90a87c6c6789a97dcd2cba8"
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
