# cenos6.5-iptables remark

## append iptables

```bash
iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 4443 -j ACCEPT
iptables -A INPUT -p tcp -m state --state NEW -m tcp --dport 8000 -j ACCEPT
service iptables save
service iptables restart
```

