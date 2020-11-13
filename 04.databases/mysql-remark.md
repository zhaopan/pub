# MYSQL Remark

## MYSQL backups

```bash
mysqldump -u root -p DATABASE>ALL.sql
```

## MYSQL recovery

```bash
mysql -u root -p DATABASE<ALL.sql
```

## Remote connection MYSQL

```bash
mysql -h 127.0.0.0 -u root -p
```