class Blackcat < Formula
  desc "Modern cat with Kitty graphics protocol, ANSI rendering, DOS/CP437 support"
  homepage "https://github.com/j-c-m/blackcat"
  url "https://github.com/j-c-m/blackcat/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "2a10bc25be9ac8a644a4301a97126298dc8a4db13bd0ecddee99db1db9b9b04d"
  license "MIT"

  bottle do
    root_url "https://github.com/j-c-m/homebrew-tap/releases/download/blackcat-0.4.5"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "285ed38128cc40915579f1e6879fadae9ef7e0e75ebdcde9466d38a74dfe273b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "db5d59711ffa26343b982035058ab8f3ed3109f4208142bb8203d5df5194b626"
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
