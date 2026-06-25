class Blackcat < Formula
  desc "Modern cat with Kitty graphics protocol, ANSI rendering, DOS/CP437 support"
  homepage "https://github.com/j-c-m/blackcat"
  url "https://github.com/j-c-m/blackcat/archive/refs/tags/v0.7.3.tar.gz"
  sha256 "ba2bc67f5ac9c0037295c62cf603048cd7b162a8386c4815561c638b1effdf47"
  license "MIT"

  bottle do
    root_url "https://github.com/j-c-m/homebrew-tap/releases/download/blackcat-0.7.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "b27d0a4060d7195761709b710c95703b0b08b3a25ada602b7d06b58f13e9900d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "012d696d8d3e690afa16cd6a6c4834a151408d9f957581bd7311fc3e0b5437d8"
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
