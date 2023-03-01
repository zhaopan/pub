# mysql-slave-conf

## service conf

```yml
#conf syn data
server-id=1 #主数据库一般都是id为1
log-bin=mysql-bin #必须的
#binlog_format=mixed #必须的，推荐类型为mixd
expire_logs_days=15 #为避免日志文件过大，设置过期时间为15天
#binlog-ignore-db = mysql #忽略同步的文件，也不记入二进制日志，可列多行
#binlog-ignore-db = information_schema
relay-log=relay-bin
relay-log-index=relay-bin-index
replicate-do-db=oto_shop_server #需要同步的文件，记入二进制日志，可列多行
#endconf syn data
```

## client conf

```yml
#conf syn data
server-id=243 #建议门店编号(整型)
expire_logs_days=15 #为避免日志文件过大，设置过期时间为15天
log-bin=mysql-bin #必须的
relay-log=relay-bin
relay-log-index=relay-bin-index
#syn all database
#replicate-do-db=oto_shop_server
#end all database
#syn data table
replicate-rewrite-db= oto_shop_server->oto_shop_server #主服务器库名A->从服务器库名B
replicate-rewrite-db= oto_shop_server->oto_shop_client
replicate_do_table=oto_shop_client.SysSet
replicate_do_table=oto_shop_client.BasicData
replicate_do_table=oto_shop_client.RgnInfo
replicate_do_table=oto_shop_client.ClassesInfo
replicate_do_table=oto_shop_client.GoodsSalesPromotion
replicate_do_table=oto_shop_client.GoodsInfo
replicate_do_table=oto_shop_client.GoodsBrand
replicate_do_table=oto_shop_client.GoodsAttribute
replicate_do_table=oto_shop_client.GoodsType
#end syn data table
#endconf syn data
```

## client slave setting

```bash
# client start slave
# eg:
stop slave;
change master to master_host='127.0.0.1',master_user='root',master_password='pwd***';
start slave;
#end client start slave
show slave status\G;    # 检查服务是否启动
change master to master_host='';    # 客户端取消主从
```

## 不完全解决办法

```bash
slave stop;
set global sql_slave_skip_counter=1;
slave start;
```
