#!/bin/bash
cd /ss
wget -O ss.tar.xz https://github.com/shadowsocks/shadowsocks-rust/releases/download/v$SSVER/shadowsocks-v$SSVER.x86_64-unknown-linux-gnu.tar.xz
wget -O vp.tar.xz https://github.com/shadowsocks/v2ray-plugin/releases/download/v$v2pVER/v2ray-plugin-linux-amd64-v$v2pVER.tar.gz
tar -xvf ss.tar.xz 
tar -xvf vp.tar.xz 
mv v2ray-plugin_linux_amd64 v2p
chmod +x ssserver v2p
./ssserver -s 0.0.0.0:8080 -m $method -k $password --plugin "./v2p" --plugin-opts "server"
