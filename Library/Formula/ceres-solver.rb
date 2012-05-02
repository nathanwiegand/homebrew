require 'formula'

class CeresSolver < Formula
  homepage 'http://code.google.com/p/ceres-solver/'

  tag = '1.0.1'
  url 'https://code.google.com/p/ceres-solver/', :tag => tag, :using => :git
  version tag

  depends_on 'cmake' => :build
  depends_on 'glog'
  depends_on 'eigen'
  depends_on 'suite-sparse'
  depends_on 'protobuf'

  def install
    system "mkdir", "ceres-bin"
    chdir "ceres-bin"
    cellar = "#{HOMEBREW_PREFIX}/Cellar/"
    system "cmake ../"
    system "make -j3"
    system "cp -R ../include #{prefix}/."
    system "cp -R ../internal #{prefix}/."
    system "mkdir -p #{prefix}/lib"
    system "cp internal/ceres/libceres.a #{prefix}/lib/."
  end
end
