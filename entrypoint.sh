
wget -q -O soc http://github.com/wangyi2005/soc-v2p/raw/master/soc-v$SOCVER
wget -q -O v2p http://github.com/wangyi2005/soc-v2p/raw/master/v2p-v$V2PVER
chmod +x soc v2p
./soc -s 0.0.0.0:8080 -m $method -k $password --plugin "./v2p" --plugin-opts "server"
