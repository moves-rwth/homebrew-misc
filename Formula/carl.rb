class Carl < Formula
  desc "Computer ARithmetic and Logic library"
  homepage "https://github.com/smtrat/carl"
  url "https://github.com/smtrat/carl/archive/c++14-20.09.tar.gz"
  version "20.09"
  sha256 "62695b339d851800a61aeb289deef11093b642c7b6aeee1f4f48c298d8cf5b35"

  head "https://github.com/smtrat/carl.git", :using => :git, :branch => "master14"

  option "with-thread-safe", "Build with thread-safe support"

  depends_on "boost"
  depends_on "cmake"
  depends_on "eigen"
  depends_on "gmp"
  depends_on "cln" => :optional
  depends_on "ginac" => :optional
  depends_on "moves-rwth/misc/cocoalib" => :optional

  def install
    args = %w[
      -DEXPORT_TO_CMAKE=OFF
      -DCMAKE_BUILD_TYPE=RELEASE
      -DEXCLUDE_TESTS_FROM_ALL=ON
    ]
    args << "-DTHREAD_SAFE=ON" if build.with?("thread-safe")
    args << "-DUSE_CLN_NUMBERS=ON" if build.with?("cln")
    args << "-DUSE_GINAC=ON" if build.with?("ginac")
    args << "-DUSE_COCOA=ON" if build.with?("cocoalib")

    mktemp do
      system "cmake", buildpath, *(std_cmake_args + args)
      system "make", "install"
    end
  end
end
