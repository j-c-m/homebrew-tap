class Blackcat < Formula
  desc "Modern cat with Kitty graphics protocol, ANSI rendering, DOS/CP437 support"
  homepage "https://github.com/j-c-m/blackcat"
  url "https://github.com/j-c-m/blackcat/archive/refs/tags/v0.7.3.tar.gz"
  sha256 "ba2bc67f5ac9c0037295c62cf603048cd7b162a8386c4815561c638b1effdf47"
  license "MIT"

  bottle do
    root_url "https://github.com/j-c-m/homebrew-tap/releases/download/blackcat-0.7.3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "ff181002d4211631d5b468a07d5878b44a067eb9dd8fd91aec415a81d6b18221"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d65acfac02b6f72693c15a40f13d0b1e8bc3cbbcd6b90557b1ae3b167c632ec2"
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
