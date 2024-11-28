@test "capabilities" {
  run R -q -f test-caps.R
  [ "$status" -eq 0 ] || echo "$output" && [ "$status" -eq 0 ]
}

@test "no extra dynamic libs" {
  RHOME=$(R -s -e 'cat(R.home())')
  LIBS="libpthread.so.0
        libm.so.6
        libdl.so.2
        libgcc_s.so.1
        libc.so.6
        ld-linux-aarch64.so.1"
  echo "$LIBS" | tr -d ' ' | sort > /tmp/oklibs
  run sh -c "patchelf --print-needed $RHOME/bin/exec/R | sort |
             comm -23 - /tmp/oklibs"
  [ "$output" = "" ] || echo "$output" && [ "$output" = "" ]

  run sh -c "patchelf --print-needed $RHOME/bin/Rscript | sort |
             comm -23 - /tmp/oklibs"
  [ "$output" = "" ] || echo "$output" && [ "$output" = "" ]

  for so in `find $RHOME -name "*.so"`; do
    run sh -c "patchelf --print-needed $so | sort |
             comm -23 - /tmp/oklibs"
    [ "$output" = "" ] || echo "$output" && [ "$output" = "" ]
  done
}

@test "BLAS/LAPACK loads" {
  run R -q -f test-blas.R
  [ "$status" -eq 0 ] || echo "$output" && [ "$status" -eq 0 ]
}

@test "libcurl works" {
  run R -q -f test-libcurl.R
  [ "$status" -eq 0 ] || echo "$output" && [ "$status" -eq 0 ]
}

@test "cairo works" {
  run R -q -f test-cairo.R
  [ "$status" -eq 0 ] || echo "$output" && [ "$status" -eq 0 ]
}

@test "install package w/ R code only" {
  run R -q -f test-install-r.R
  [ "$status" -eq 0 ] || echo "$output" && [ "$status" -eq 0 ]
}

@test "install package w/ C code" {
  run R -q -f test-install-c.R
  [ "$status" -eq 0 ] || echo "$output" && [ "$status" -eq 0 ]
}

@test "install package w/ C++ code" {
  run R -q -f test-install-cpp.R
  [ "$status" -eq 0 ] || echo "$output" && [ "$status" -eq 0 ]
}

@test "install package w/ Fortran code" {
  run R -q -f test-install-fortran.R
  [ "$status" -eq 0 ] || echo "$output" && [ "$status" -eq 0 ]
}

@test "install package w/ BLAS/LAPACK dependency {
  run R -q -f test-install-blas.R
  [ "$status" -eq 0 ] || echo "$output" && [ "$status" -eq 0 ]
}
