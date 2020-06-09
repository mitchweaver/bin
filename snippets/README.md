# Snippets

Small scripts that aren't big enough to belong anywhere else.

## `add_ssh_hosts_to_etc_hosts.sh`

Helpful for local web based services.

Example input:

```
# $ ~/.cache/ssh/config
Host pi
    HostName 192.168.0.2
Host webserver
    HostName 192.168.0.3
Host grafana
    HostName 192.168.0.4
```

Example output:

```
192.168.0.2 pi
192.168.0.3 webserver
192.168.0.4 grafana
```
