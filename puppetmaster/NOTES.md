# Some notes

### Puppet certs with dns-alt-names

```
puppet certificate generate --ca-location local --dns-alt-names puppet.domain.com,puppet,something puppet
puppet cert sign --allow-dns-alt-names puppet
```
