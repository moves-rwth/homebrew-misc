class Cocoalib < Formula
  desc "CoCoALib is a GPL C++ library for doing Computations in Commutative Algebra."
  homepage "http://cocoa.dima.unige.it/cocoalib/"
  url "http://cocoa.dima.unige.it/cocoalib/tgz/CoCoALib-0.99555.tgz"
  version "0.99555"
  sha256 "0a7d96789885027c7fcb875f281aadb613ab5e7ff6e1f233abbf2c499136c517"

  depends_on "gmp" => ["c++11"]

  def install
    # Fix for old version of CoCoALib that refers to tr1 headers (thanks to Sebastian Arming, https://github.com/sarming).
    for file in ["Lexer", "Main", "LineProviders"]
        inreplace "src/CoCoa-5/#{file}.C", "boost/tr1/memory.hpp","memory"
    end

    system "mkdir", "#{prefix}/include"
    system "mkdir", "#{prefix}/lib"

    system "./configure", "--threadsafe-hack", "--with-cxxflags=-Wno-deprecated-declarations -fPIC", "--prefix=#{prefix}"
    system "make", "all"
    system "make", "install"
  end
end
