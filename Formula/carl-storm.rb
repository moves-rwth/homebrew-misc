class CarlStorm < Formula
  desc "Computer ARithmetic and Logic library for the probabilistic model checker Storm"
  homepage "https://ths-rwth.github.io/carl/"
  url "https://github.com/moves-rwth/carl-storm/archive/refs/tags/14.25.tar.gz"
  version "14.25"
  sha256 "511740d53c2a6a41c3ccb3bd3b2d9ec89d0576f37b8804fc15fbe083e7a357da"

  head "https://github.com/moves-rwth/carl-storm.git", using: :git

  option "with-thread-safe", "Build with thread-safe support"

  depends_on "boost"
  depends_on "cmake"
  depends_on "eigen"
  depends_on "gmp"
  on_intel do
    depends_on "cln" => :optional
    depends_on "ginac" => :optional
  end
  depends_on "moves-rwth/misc/cocoalib" => :optional

  def install
    args = %w[
      -DEXPORT_TO_CMAKE=OFF
      -DCMAKE_BUILD_TYPE=RELEASE
      -DEXCLUDE_TESTS_FROM_ALL=ON
    ]
    args << "-DTHREAD_SAFE=ON" if build.with?("thread-safe")
    args << "-DUSE_CLN_NUMBERS=ON" if build.with?("cln") && Hardware::CPU.intel?
    args << "-DUSE_GINAC=ON" if build.with?("ginac") && Hardware::CPU.intel?
    args << "-DUSE_CLN_NUMBERS=OFF -DUSE_GINAC=OFF" if Hardware::CPU.arm?
    args << "-DUSE_COCOA=ON" if build.with?("cocoalib")

    mktemp do
      system "cmake", buildpath, *(std_cmake_args + args)
      system "make", "install"
    end
  end
end
