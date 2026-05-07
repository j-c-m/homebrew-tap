class Blackcat < Formula
  desc "Modern cat with Kitty graphics protocol, ANSI rendering, DOS/CP437 support"
  homepage "https://github.com/j-c-m/blackcat"
  url "https://github.com/j-c-m/blackcat/archive/refs/tags/v0.6.0.tar.gz"
  sha256 "ee00498989bf74218c1ae18cc0354499d95b33824273629508d486ef6602fee8"
  license "MIT"

  bottle do
    root_url "https://github.com/j-c-m/homebrew-tap/releases/download/blackcat-0.6.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "b57c3fdf7d0737cf2c8b730a14d4f8559efc98e5c5e10f3e72cfc5056d90c471"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3632c8c08230dae858efd9c8c70b3d156fb7f719405e4844c8c690411c11563f"
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
