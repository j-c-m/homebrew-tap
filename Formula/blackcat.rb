class Blackcat < Formula
  desc "Modern cat with Kitty graphics protocol, ANSI rendering, DOS/CP437 support"
  homepage "https://github.com/j-c-m/blackcat"
  url "https://github.com/j-c-m/blackcat/archive/refs/tags/v0.9.0.tar.gz"
  sha256 "4e5259c56985e255f4a57a9547a9fc11e5f66cabeb8817ccefa0e0b08b9c2d7a"
  license "MIT"

  bottle do
    root_url "https://github.com/j-c-m/homebrew-tap/releases/download/blackcat-0.8.3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "9707dbbf36a6a8584bed5178879be9c084dd9b9f31e2928dbf4c6d50fb0f8c30"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9f0bbdb8255688cf5ef8df15f09c224a5c5bf432e05488ef0879749b65ef9b6b"
  end

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_equal "hello\n", pipe_output(bin/"blackcat", "hello\n")
    assert_match version.to_s, shell_output("#{bin}/blackcat --version")
    assert_match "Kitty protocol", shell_output("#{bin}/blackcat --help")
  end
end
