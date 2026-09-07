class Blackcat < Formula
  desc "Modern cat with Kitty graphics protocol, ANSI rendering, DOS/CP437 support"
  homepage "https://github.com/j-c-m/blackcat"
  url "https://github.com/j-c-m/blackcat/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "f5b681365516970fd18f33900e12e0a29c54627cf82282d7fedad597457983ea"
  license "MIT"

  bottle do
    root_url "https://github.com/j-c-m/homebrew-tap/releases/download/blackcat-0.8.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "414f62cc7d98c3fc18f586b00ff426698aec566b0f2ce1bcee8992b0d02b4eb6"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "117c83fcd9e563f869eafe2c8007468a83a00a1d06ae96420e76a1419c44cdb9"
  end

  depends_on "zig@0.16" => :build

  def install
    system "zig", "build", "-Doptimize=ReleaseSmall", "-Dpackage_release=false"
    bin.install "zig-out/bin/blackcat"
  end

  test do
    assert_equal "hello\n", pipe_output(bin/"blackcat", "hello\n")
    assert_match version.to_s, shell_output("#{bin}/blackcat --version")
    assert_match "Kitty protocol", shell_output("#{bin}/blackcat --help")
  end
end
