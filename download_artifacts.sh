#!/usr/bin/env bash

repos=( "Javafx-WebView-Debugger" )
repos_ids=( "5811342" )

rm -r artifacts
mkdir artifacts

# for index in {0..1}
# do
  index=0
  repo=${repos[$index]}
  repo_id=${repos_ids[$index]}
  curl \
    -L \
    -o artifacts/$repo.zip \
    -H "PRIVATE-TOKEN: ${CI_API_TOKEN}" \
      http://gitlab.com/api/v4/projects/$repo_id/jobs/artifacts/master/download?job=build

  unzip artifacts/${repo}.zip -d artifacts/${repo}

  mv artifacts/${repo}/target/mvn-repo/* site/
# done
