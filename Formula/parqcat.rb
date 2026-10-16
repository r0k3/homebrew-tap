class Parqcat < Formula
  desc "A lightweight Unix-style CLI for inspecting Parquet files."
  homepage "https://github.com/r0k3/parqcat"
  version "1.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/r0k3/parqcat/releases/download/v1.0.3/parqcat-aarch64-apple-darwin.tar.xz"
      sha256 "a017f9970ee6300c323ccae9e3ae4204c78c3c4680d9b7067a40cbcdf6099fe4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/r0k3/parqcat/releases/download/v1.0.3/parqcat-x86_64-apple-darwin.tar.xz"
      sha256 "7bc6629d270a0039383ce7f3a5a40c37161d5df64ad6f0e139f895872589eff9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/r0k3/parqcat/releases/download/v1.0.3/parqcat-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "abcd20b7cabf22a65e18a981a7788ee8664e7c34df93f3ded301dd9633a6bcc6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/r0k3/parqcat/releases/download/v1.0.3/parqcat-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1a5bcc2bbf602ae1394eda3ba8f7260e9fc3d942832766b8d95afaf31a44e349"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "parqcat"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "parqcat"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "parqcat"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "parqcat"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
