if [[ helm_major_version -eq 3 ]]; then
  yaml_overwrite_tmp=$(mktemp -d)
  yaml_feature_golden_dir=${dir}/yaml-features-golden
  yaml_overwrite_reverse=${yaml_overwrite_tmp}/yaml.override.build.yaml

  test_start "yaml overwrite feature"
  info "Comparing yaml overwrite feature output ${yaml_overwrite_reverse} with ${yaml_feature_golden_dir}/overwritten.yaml"
  for i in $(seq 10); do
      info "Comparing build/yaml-overwrite #$i"
      ${helmfile} -f ${dir}/issue.657.yaml template --skip-deps > ${yaml_overwrite_reverse} || fail "\"helmfile template\" shouldn't fail"
      ./yamldiff ${yaml_feature_golden_dir}/overwritten.yaml ${yaml_overwrite_reverse} || fail "\"helmfile template\" should be consistent"
      echo code=$?
  done
  test_pass "yaml overwrite feature"
fi