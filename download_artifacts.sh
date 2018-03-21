#!/usr/bin/env bash

repos=( "Javafx-WebView-Debugger" "monaco.editor" )

rm -r artifacts
mkdir artifacts

alias curl="curl –silent"

for repo in "${repos[@]}"
do
  build_info=$(curl "https://circleci.com/api/v1.1/project/github/CueNinja/${repo}?circle-token=${CI_TOKEN}&limit=1&filter=completed")
  build_num=$(echo $build_info | jq ". [0] .build_num")
  build_num=`expr $build_num - 1`
  artifact_info=$(curl "https://circleci.com/api/v1.1/project/github/CueNinja/${repo}/${build_num}/artifacts?circle-token=${CI_TOKEN}")
  artifact_url=$(echo $artifact_info | jq ".[] .url" | sed "s/\"//g")
  echo "Downloading ${artifact_url}"
  curl -o artifacts/${repo}.tar.gz "${artifact_url}?circle-token=${CI_TOKEN}"

  mkdir artifacts/${repo}/
  cd artifacts/${repo}/
  tar -xf ../${repo}.tar.gz
  cd -
  cp -R artifacts/${repo}/* site/
done
