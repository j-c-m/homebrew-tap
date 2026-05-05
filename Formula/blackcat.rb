class Blackcat < Formula
  desc "Modern cat with Kitty graphics protocol, ANSI rendering, DOS/CP437 support"
  homepage "https://github.com/j-c-m/blackcat"
  url "https://github.com/j-c-m/blackcat/archive/refs/tags/v0.5.2.tar.gz"
  sha256 "15d924b0e1d800ec8866cdfc5da803be4a1f729a7fe81493b798d14c34d884e1"
  license "MIT"

  bottle do
    root_url "https://github.com/j-c-m/homebrew-tap/releases/download/blackcat-0.5.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "e5c74ebd73af2f523d01c77ddf410a10b682baecfdd95f6eeb7f1e2f026dce4c"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "25857b7e098958214fad4eab1a06182e835b94cff073674abe81bacbf13b434a"
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
