class Blackcat < Formula
  desc "Modern cat with Kitty graphics protocol, ANSI rendering, DOS/CP437 support"
  homepage "https://github.com/j-c-m/blackcat"
  url "https://github.com/j-c-m/blackcat/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "accb6751851c5e1921e1562eaac43db199a9f59ece7dca623850c9ac71f28035"
  license "MIT"

  bottle do
    root_url "https://github.com/j-c-m/homebrew-tap/releases/download/blackcat-0.5.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "71b2e26a56294eb0f3337760c37556f1f3ebdccf6b31d17bc548145c8216de12"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6ff9a84e06059ae2902fda1192988a049c69cba3b76cd1e0c91b9272d6ad3222"
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
