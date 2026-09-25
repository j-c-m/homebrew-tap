class Blackcat < Formula
  desc "Modern cat with Kitty graphics protocol, ANSI rendering, DOS/CP437 support"
  homepage "https://github.com/j-c-m/blackcat"
  url "https://github.com/j-c-m/blackcat/archive/refs/tags/v0.9.1.tar.gz"
  sha256 "51f18056b8466226350f13c80ed7323eb1c9d22ce7afd8e41919679fdb49a9b6"
  license "MIT"

  bottle do
    root_url "https://github.com/j-c-m/homebrew-tap/releases/download/blackcat-0.9.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "25567fa6e1ee075d7f0f771148ced158c42e0f13371a45c24682bd1045333c41"
    sha256 cellar: :any,                 x86_64_linux: "0fe3541de4a8b2c88321bbd3a83da6b5a8f28074eed29d620400f7fb7012774e"
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
