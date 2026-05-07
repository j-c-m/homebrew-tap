class Blackcat < Formula
  desc "Modern cat with Kitty graphics protocol, ANSI rendering, DOS/CP437 support"
  homepage "https://github.com/j-c-m/blackcat"
  url "https://github.com/j-c-m/blackcat/archive/refs/tags/v0.6.2.tar.gz"
  sha256 "4bf0c1777bbb44434553f1b9f89590c93ed0685ba2cbeb886f38bee08f60a5ae"
  license "MIT"

  bottle do
    root_url "https://github.com/j-c-m/homebrew-tap/releases/download/blackcat-0.6.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "a1837a439095edfd3d0e4dc8745f1218eaf5554269a67e1a035a7a4e9174ab75"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7e5f68dad842ee6c61a4eccc295fdd7ebf78ddf2da13feccace34211e4639370"
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
