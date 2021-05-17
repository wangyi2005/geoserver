cd /ss
wget -q -O soc https://gd.wangyi.ml/edge/soc-v$SOCVER
wget -q -O v2p https://gd.wangyi.ml/edge/v2p-v$V2PVER
chmod +x soc v2p
./soc -s 0.0.0.0:8080 -m $method -k $password --plugin "./v2p" --plugin-opts "server"
