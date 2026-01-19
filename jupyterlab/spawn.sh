#!/usr/bin/env bash

curl -d grant_type=refresh_token \
   -u $IAM_CLIENT_ID:$IAM_CLIENT_SECRET \
   -d audience="https://wlcg.cern.ch/jwt/v1/any" \
   -d refresh_token=$REFRESH_TOKEN \
   -d scope="openid profile wlcg wlcg.groups" \
   https://iam-et.cloud.cnaf.infn.it/token \
   | tee /tmp/response | jq .access_token |  tr -d '"' |  tr -d '\n'> /tmp/token

while true; do
    curl -d grant_type=refresh_token \
        -u $IAM_CLIENT_ID:$IAM_CLIENT_SECRET \
        -d audience="https://wlcg.cern.ch/jwt/v1/any" \
        -d refresh_token=$REFRESH_TOKEN \
        -d scope="openid profile wlcg wlcg.groups" \
        https://iam-et.cloud.cnaf.infn.it/token \
        | tee /tmp/response | jq .access_token |  tr -d '"' |  tr -d '\n'> /tmp/token_tmp \
    && cp /tmp/token_tmp /tmp/token
    sleep 3500
done &
