class Blackcat < Formula
  desc "Modern cat with Kitty graphics protocol, ANSI rendering, DOS/CP437 support"
  homepage "https://github.com/j-c-m/blackcat"
  url "https://github.com/j-c-m/blackcat/archive/refs/tags/v0.7.2.tar.gz"
  sha256 "e5b3b0249d62ef3e40d803803f944eb36f10e6bf385af8a6686c3fbdab47ce59"
  license "MIT"

  bottle do
    root_url "https://github.com/j-c-m/homebrew-tap/releases/download/blackcat-0.7.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "66e0d3f849bec102945d85708d3d424d57c646dfa0b24ccba50704aa10985fcf"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "eb45076b9b7e11d4373e4c592ac86f0051a0b6faad0b81dbac8b62532c419651"
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
