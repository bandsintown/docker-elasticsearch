@test "package 'curl' should be present" {
  run which curl
  [ $status -eq 0 ]
}

@test "package 'wget' should be present" {
  run which wget
  [ $status -eq 0 ]
}

@test "package 'bash' should be present" {
  run which bash
  [ $status -eq 0 ]
}

@test "package 'jq' should be present" {
  run which jq
  [ $status -eq 0 ]
}

@test "package 'dig' should be present" {
  run which dig
  [ $status -eq 0 ]
}

@test "package 'nslookup' should be present" {
  run which nslookup
  [ $status -eq 0 ]
}

@test "package 'consul-template' should be present" {
  run which consul-template
  [ $status -eq 0 ]
}
