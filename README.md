# sshpass
使用ssh密码验证时能够提供密码参数，在编写shell脚本时提供方便，不建议在命令行使用。
支持scp

用法:
可以直接取代ssh使用，用法与ssh命令一致
多了一个 --password 参数用来提供密码

如：
./sshpass.sh ssh root@127.0.0.1 --password liyunwei

./sshpass.sh scp root@127.0.0.1:/tmp/test ./test --password liyunwei


