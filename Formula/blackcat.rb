class Blackcat < Formula
  desc "Modern cat with Kitty graphics protocol, ANSI rendering, DOS/CP437 support"
  homepage "https://github.com/j-c-m/blackcat"
  url "https://github.com/j-c-m/blackcat/archive/refs/tags/v0.8.3.tar.gz"
  sha256 "cca66c83a3dfe6bafa82f38d792fce12c55222babc5194df636cbaae577235f1"
  license "MIT"

  bottle do
    root_url "https://github.com/j-c-m/homebrew-tap/releases/download/blackcat-0.8.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "4faeec1f1c0aa06722b5277db4d568433ca6e5adc25757c81788c163b574e8cb"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "813d1c08fa9b1413b1d27cf683c0de20ad7188cb5613bd8cf0f733f6e196f18e"
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
