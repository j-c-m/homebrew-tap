class Blackcat < Formula
  desc "Modern cat with Kitty graphics protocol, ANSI rendering, DOS/CP437 support"
  homepage "https://github.com/j-c-m/blackcat"
  url "https://github.com/j-c-m/blackcat/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "0e7ff8481083406f8a0f79a2a2e609e971496ad3899b77c2b2dab119c3cf0f66"
  license "MIT"

  bottle do
    root_url "https://github.com/j-c-m/homebrew-tap/releases/download/blackcat-0.7.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "b7e5a0f25793ce1ea2b2c8d850acb3d2712f545cc68374a2335de0017ddb0c1d"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "926cf286745b157c49329c70f3c81424974376d21fd55b36838e47897038672d"
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
