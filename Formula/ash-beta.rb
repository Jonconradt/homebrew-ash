class AshBeta < Formula
  desc "AI assistant for bash, Fish, and zsh"
  homepage "https://github.com/Jonconradt/ash"
  version "0.27.0-beta.5"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-beta.5/ash-v0.27.0-beta.5-darwin-arm64.tar.gz"
      sha256 "e421e45828b3c970033b83fc6db26c6516bda0502172dc5e0f0ac91889635f1e"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-beta.5/ash-v0.27.0-beta.5-darwin-amd64.tar.gz"
      sha256 "ab7db95ff85167b65ba48e8d9dba4042bb8ec2f352b84ee1dbf7f38ca9b88ddd"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-beta.5/ash-v0.27.0-beta.5-linux-arm64.tar.gz"
      sha256 "6b69fb98f197ced8f8adf8cf82a1b90145b0214bc26b9536da241fec1434cc03"
    end
    on_intel do
      url "https://github.com/Jonconradt/ash/releases/download/v0.27.0-beta.5/ash-v0.27.0-beta.5-linux-amd64.tar.gz"
      sha256 "77ad8722f177a5355e69f6036a6c4700bfc68450ebd60d0741fc04142aaac4a8"
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
