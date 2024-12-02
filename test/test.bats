@test "capabilities" {
  run R -q -f test-caps.R
  [ "$status" -eq 0 ] || echo "$output" && [ "$status" -eq 0 ]
}

@test "no extra dynamic libs" {
  if command -v patchelf; then
    run R -q -s -f test-dynlibs.R;
  else
    run true
  fi
  [ "$status" -eq 0 ] || echo "$output" && [ "$status" -eq 0 ]
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
