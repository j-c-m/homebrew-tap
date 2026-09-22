class Blackcat < Formula
  desc "Modern cat with Kitty graphics protocol, ANSI rendering, DOS/CP437 support"
  homepage "https://github.com/j-c-m/blackcat"
  url "https://github.com/j-c-m/blackcat/archive/refs/tags/v0.8.1.tar.gz"
  sha256 "c8d69b7c44fb2a28276e5279c57a36f13c5eb89910feefbf2516f43431267ff6"
  license "MIT"

  bottle do
    root_url "https://github.com/j-c-m/homebrew-tap/releases/download/blackcat-0.8.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "eacbefad89f5e50d0021ac5ae5fcd3fe5fe0c1432e87299cb3408a5d18f6d0a3"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9a630ee20e6b1954db7138e84d7e7a97f4d26641780577d61ccba6f454eb8c30"
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
