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

@test "install package w/ BLAS/LAPACK dependency" {
  run R -q -f test-install-blas.R
  [ "$status" -eq 0 ] || echo "$output" && [ "$status" -eq 0 ]
}

@test "CVE-2024-27322" {
  run R -q -f test-cve-2024-27322.R
  [ "$status" -eq 0 ] || echo "$output" && [ "$status" -eq 0 ]
}

@test "X11" {
  Xvfb :1 -screen 0 1280x1024x24 &
  pid=$!
  trap "kill -15 $pid || kill -9 $pid" EXIT
  export DISPLAY=:1
  run R -q -f test-x11.R
  kill -15 $pid 2>/dev/null
  [ "$status" -eq 0 ] || echo "$output" && [ "$status" -eq 0 ]
}

@test "pager" {
  run R -q -f test-pager.R
  [ "$status" -eq 0 ] || echo "$output" && [ "$status" -eq 0 ]
}

@test "zip, unzip" {
  run R -q -f test-zip.R
  [ "$status" -eq 0 ] || echo "$output" && [ "$status" -eq 0 ]
}
