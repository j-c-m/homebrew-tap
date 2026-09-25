class Blackcat < Formula
  desc "Modern cat with Kitty graphics protocol, ANSI rendering, DOS/CP437 support"
  homepage "https://github.com/j-c-m/blackcat"
  url "https://github.com/j-c-m/blackcat/archive/refs/tags/v0.9.1.tar.gz"
  sha256 "51f18056b8466226350f13c80ed7323eb1c9d22ce7afd8e41919679fdb49a9b6"
  license "MIT"

  bottle do
    root_url "https://github.com/j-c-m/homebrew-tap/releases/download/blackcat-0.9.0"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "14102553509e13bbb268bd8e850fb2a51e761416caab851501f09d5869ccc729"
    sha256 cellar: :any,                 x86_64_linux: "7d503c757e3d19db8fb74010be38220afb97df6238fe16860c22099b5739f337"
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
