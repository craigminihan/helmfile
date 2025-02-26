
test_start "regression tests"

if [[ helm_major_version -eq 3 ]]; then
  info "https://github.com/roboll/helmfile/issues/1857"
  (${helmfile} -f ${dir}/issue.1857.yaml --state-values-set grafanaEnabled=true template | grep grafana 1>/dev/null) || fail "\"helmfile template\" shouldn't include grafana"
  ! (${helmfile} -f ${dir}/issue.1857.yaml --state-values-set grafanaEnabled=false template | grep grafana) || fail "\"helmfile template\" shouldn't include grafana"

  info "https://github.com/roboll/helmfile/issues/1867"
  (${helmfile} -f ${dir}/issue.1867.yaml template 1>/dev/null) || fail "\"helmfile template\" shouldn't fail"

  info "https://github.com/roboll/helmfile/issues/2118"
  (${helmfile} -f ${dir}/issue.2118.yaml template 1>/dev/null) || fail "\"helmfile template\" shouldn't fail"
else
  info "There are no regression tests for helm 2 because all the target charts have dropped helm 2 support."
fi

test_pass "regression tests"