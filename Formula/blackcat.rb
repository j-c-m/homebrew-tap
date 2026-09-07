class Blackcat < Formula
  desc "Modern cat with Kitty graphics protocol, ANSI rendering, DOS/CP437 support"
  homepage "https://github.com/j-c-m/blackcat"
  url "https://github.com/j-c-m/blackcat/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "f5b681365516970fd18f33900e12e0a29c54627cf82282d7fedad597457983ea"
  license "MIT"

  bottle do
    root_url "https://github.com/j-c-m/homebrew-tap/releases/download/blackcat-0.7.4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "d2b794966e32b16cf0cc73587645ad4958c6abdcb10500acaf7621a5e29908f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "64f2b9ab7dcaec9b9a8c800c9313578b10eb2f8275b8f2c15457346dbb1dfd54"
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
