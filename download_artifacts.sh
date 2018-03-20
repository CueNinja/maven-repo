#!/usr/bin/env bash

repos=( "Javafx-WebView-Debugger" )

rm -r artifacts
mkdir artifacts

# for index in {0..1}
# do
  index=0
  repo=${repos[$index]}
  build_info=$(curl "https://circleci.com/api/v1.1/project/github/CueNinja/${repo}?circle-token=${CI_TOKEN}&limit=1&filter=completed")
  build_num=$(echo $build_info | jq ". [0] .build_num")
  artifact_info=$(curl "https://circleci.com/api/v1.1/project/github/CueNinja/${repo}/${build_num}/artifacts?circle-token=${CI_TOKEN}")
  artifact_url=$(echo $artifact_info | jq ".[] .url" | sed "s/\"//g")
  curl -o artifacts/${repo}.tar.gz "${artifact_url}?circle-token=${CI_TOKEN}"

  mkdir artifacts/${repo}/
  cd artifacts/${repo}/
  tar -xf ../${repo}.tar.gz
  cd -
  mv artifacts/${repo}/target/mvn-repo/* site/
# done
