# lazyzone

A simple preprocessor for zone files written in awk. Creates forward and reverse zones from one single file.

## Why?

Some DNS zones are rather boring: just A records for each machine/interface and its PTR records in the reverse zone. No other resource type. Just a list of all devices in your network which is edited frequently. Over time the great amount of quite similiar lines becomes more and more unreadable. And you make mistakes: forward and backward zones get out of sync or you forget about some interfaces.

Lazyzone allows you to write your zone in a more compact form with less typing and less possibilities to make mistakes. It's far from a perfect solution, but it fits my own needs!

## How?

Input is just a simple two-column text-file:

    [eth0.]server  10.0.0.1
    fc0.server     192.168.0.1
    desktop        10.0.0.100-200

Put parts of the name in square brackets to create an additional CNAME of the shorter name outside brackets to the full name given.

If the last octed of the address consists of a range, multiple records are created. Each record's name is appended the increasing value of a counter.

## Parameters

(supply each via: `-v key=value`)

- `domain` value for `$ORIGIN`
- `ttl` default `$TTL`-value for zone (append unit, e.g. `1d`)
- `dns_server` which dns-server is authorative for this zone
- `mail` mailbox of dns-admin
- `serial` serial-number for SOA record
- `refresh` slave refresh after `refresh` seconds
- `retry` time between retries of the slave
- `expire` slave won't answer authoritatively if not reaching the master within `expire` seconds
- `minimum_ttl` negative caching time
- `reverse_prefix` if set a reverse-zone will be generated containing all ips of the supplied prefix
  
## Installation

Make sure that mawk or gawk is installed, then run:

    sudo make install

If you need a Debian package, run:

    make deb
    sudo apt-get install debian/lazyzone-0.1.0.deb

## License

This software is licensed under [GPLv3](COPYING).
