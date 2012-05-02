require 'formula'

class CeresSolver < Formula
  homepage 'http://code.google.com/p/ceres-solver/'
  url 'http://ceres-solver.googlecode.com/files/ceres-solver-1.0.0.tar.gz'
  md5 '04aee50ab36cadc8553d91d776bc2759'

  depends_on 'cmake' => :build
  depends_on 'glog'
  depends_on 'eigen'
  depends_on 'suite-sparse'
  depends_on 'protobuf'

  def install
    system "mkdir", "ceres-bin"
    chdir "ceres-bin"
    cellar = "#{HOMEBREW_PREFIX}/Cellar/"
    system "cmake", "../",
                    "-DEIGEN_INCLUDE=#{cellar}/eigen/3.0.5/include/eigen3/",
                    "-DSEARCH_HEADERS=#{cellar}/suite-sparse/3.7.0/include/",
                    "-SEARCH_LIBS=#{cellar}/suite-sparse/3.7.0/lib/"
    system "make -j3"
    system "cp -R ../include #{prefix}/."
    system "cp -R ../internal #{prefix}/."
    system "mkdir -p #{prefix}/lib"
    system "cp internal/ceres/libceres.a #{prefix}/lib/."

    # Copy the genearted protocol buffers to internal/
    system "cp internal/ceres/matrix.pb.{h,cc} #{prefix}/internal/ceres/."
  end
end
