class Blackcat < Formula
  desc "Modern cat with Kitty graphics protocol, ANSI rendering, DOS/CP437 support"
  homepage "https://github.com/j-c-m/blackcat"
  url "https://github.com/j-c-m/blackcat/archive/refs/tags/v0.6.2.tar.gz"
  sha256 "1e48ca9a60ee1f468fe4058702716da1605eac4b4130fd79e19e31f6207957b6"
  license "MIT"

  bottle do
    root_url "https://github.com/j-c-m/homebrew-tap/releases/download/blackcat-0.6.2"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "33ed16216ac7e5cc603ff5ee4406b2451ccca390a36449bdeef1bf3b83c1df7b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "241a0737d87e7c803e2e9c999424ad0685daf5679a8de26c977e89b10176359b"
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
