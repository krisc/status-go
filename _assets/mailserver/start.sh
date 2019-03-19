#!/bin/bash

MAILSERVER_IMAGE="${MAILSERVER_IMAGE:-statusteam/status-go:0.23.0-beta.6}"
DEFAULT_HOST_DATA_DIR="$HOME/.status-node"
HOST_DATA_DIR="${HOST_DATA_DIR:-"${DEFAULT_HOST_DATA_DIR}"}"
DOCKER_CONTAINER="${DOCKER_CONTAINER:-status-mailserver-node}"
EXTERNAL_ADDRESS=${EXTERNAL_ADDRESS:-}

if [ ! -x "$(command -v docker)" ]; then
  echo "Please install docker. For instructions refer to https://docs.docker.com/install/"
  exit 1
fi

echo "Create directory ${HOST_DATA_DIR}."
mkdir -p $HOST_DATA_DIR
rm -f "$HOST_DATA_DIR/config.json"
echo "Create configuration file: ${HOST_DATA_DIR}/config.json."
cat <<EOF >> "$HOST_DATA_DIR/config.json"
{
  "DataDir": "/data",
  "Rendezvous": true,
  "NoDiscovery": false,
  "IPCEnabled": true,
  "IPCFile": "/geth.ipc",
  "AdvertiseAddr": "${EXTERNAL_ADDRESS}",
  "ClusterConfig": {
    "Enabled": true,
    "Fleet": "eth.beta",
    "BootNodes": [
      "enode://e8a7c03b58911e98bbd66accb2a55d57683f35b23bf9dfca89e5e244eb5cc3f25018b4112db507faca34fb69ffb44b362f79eda97a669a8df29c72e654416784@47.91.224.35:30404",
      "enode://436cc6f674928fdc9a9f7990f2944002b685d1c37f025c1be425185b5b1f0900feaf1ccc2a6130268f9901be4a7d252f37302c8335a2c1a62736e9232691cc3a@174.138.105.243:30404",
      "enode://7427dfe38bd4cf7c58bb96417806fab25782ec3e6046a8053370022cbaa281536e8d64ecd1b02e1f8f72768e295d06258ba43d88304db068e6f2417ae8bcb9a6@104.154.88.123:30404",
      "enode://43947863cfa5aad1178f482ac35a8ebb9116cded1c23f7f9af1a47badfc1ee7f0dd9ec0543417cc347225a6e47e46c6873f647559e43434596c54e17a4d3a1e4@47.52.74.140:30404",
      "enode://5395aab7833f1ecb671b59bf0521cf20224fe8162fc3d2675de4ee4d5636a75ec32d13268fc184df8d1ddfa803943906882da62a4df42d4fccf6d17808156a87@206.189.243.57:30404",
      "enode://ebefab39b69bbbe64d8cd86be765b3be356d8c4b24660f65d493143a0c44f38c85a257300178f7845592a1b0332811542e9a58281c835babdd7535babb64efc1@35.202.99.224:30404"
    ],
    "TrustedMailServers": [
      "enode://da61e9eff86a56633b635f887d8b91e0ff5236bbc05b8169834292e92afb92929dcf6efdbf373a37903da8fe0384d5a0a8247e83f1ce211aa429200b6d28c548@47.91.156.93:30504",
      "enode://c42f368a23fa98ee546fd247220759062323249ef657d26d357a777443aec04db1b29a3a22ef3e7c548e18493ddaf51a31b0aed6079bd6ebe5ae838fcfaf3a49@206.189.243.162:30504",
      "enode://7de99e4cb1b3523bd26ca212369540646607c721ad4f3e5c821ed9148150ce6ce2e72631723002210fac1fd52dfa8bbdf3555e05379af79515e1179da37cc3db@35.188.19.210:30504",
      "enode://744098ab6d3308af5cd03920aea60c46d16b2cd3d33bf367cbaf1d01c2fcd066ff8878576d0967897cd7dbb0e63f873cc0b4f7e4b0f1d7222e6b3451a78d9bda@47.89.20.15:30504",
      "enode://7aa648d6e855950b2e3d3bf220c496e0cae4adfddef3e1e6062e6b177aec93bc6cdcf1282cb40d1656932ebfdd565729da440368d7c4da7dbd4d004b1ac02bf8@206.189.243.169:30504",
      "enode://015e22f6cd2b44c8a51bd7a23555e271e0759c7d7f52432719665a74966f2da456d28e154e836bee6092b4d686fe67e331655586c57b718be3997c1629d24167@35.226.21.19:30504",
      "enode://74957e361ab290e6af45a124536bc9adee39fbd2f995a77ace6ed7d05d9a1c7c98b78b2df5f8071c439b9c0afe4a69893ede4ad633473f96bc195ddf33f6ce00@47.52.255.195:30504",
      "enode://8a64b3c349a2e0ef4a32ea49609ed6eb3364be1110253c20adc17a3cebbc39a219e5d3e13b151c0eee5d8e0f9a8ba2cd026014e67b41a4ab7d1d5dd67ca27427@206.189.243.168:30504",
      "enode://531e252ec966b7e83f5538c19bf1cde7381cc7949026a6e499b6e998e695751aadf26d4c98d5a4eabfb7cefd31c3c88d600a775f14ed5781520a88ecd25da3c6@35.225.227.79:30504"
    ],
    "StaticNodes": [
      "enode://19872f94b1e776da3a13e25afa71b47dfa99e658afd6427ea8d6e03c22a99f13590205a8826443e95a37eee1d815fc433af7a8ca9a8d0df7943d1f55684045b7@35.238.60.236:30305",
      "enode://960777f01b7dcda7c58319e3aded317a127f686631b1702a7168ad408b8f8b7616272d805ddfab7a5a6bc4bd07ae92c03e23b4b8cd4bf858d0f74d563ec76c9f@47.52.58.213:30305"
    ],
    "RendezvousNodes": [
      "/ip4/174.138.105.243/tcp/30703/ethv4/16Uiu2HAmRHPzF3rQg55PgYPcQkyvPVH9n2hWsYPhUJBZ6kVjJgdV",
      "/ip4/206.189.243.57/tcp/30703/ethv4/16Uiu2HAmLqTXuY4Sb6G28HNooaFUXUKzpzKXCcgyJxgaEE2i5vnf"
    ]
  },
  "WhisperConfig": {
    "DataDir": "/data/mail",
    "Enabled": true,
    "EnableNTPSync": true,
    "EnableMailServer": true,
    "MailServerPassword": "status-offline-inbox"
  }
}
EOF

docker rm -f $DOCKER_CONTAINER &> /dev/null || true
echo "Start docker container: '${DOCKER_CONTAINER}' using image '${MAILSERVER_IMAGE}'."
docker run -d --name $DOCKER_CONTAINER --network host -v $HOST_DATA_DIR:/data $MAILSERVER_IMAGE -c /data/config.json | $1 > /dev/null
docker exec -ti $DOCKER_CONTAINER bash -c "while [ -f /geth.ipc ]; do sleep 1; done"
ENODE=$(docker exec -ti $DOCKER_CONTAINER bash -c "echo '{\"jsonrpc\":\"2.0\",\"method\":\"admin_nodeInfo\",\"id\":1}' | socat - UNIX-CONNECT:/geth.ipc | jq '.result.enode'")
echo "Mailserver enode: ${ENODE}"
