#!/bin/bash
cd /ss
wget -O soc https://github.com/wangyi2005/ss-docker/soc-v$SOCVER
wget -O v2p https://github.com/wangyi2005/ss-docker/v2p-v$V2PVER
chmod +x soc v2p
./soc -s 0.0.0.0:8080 -m $method -k $password --plugin "./v2p" --plugin-opts "server"
