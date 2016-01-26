philter
============
> A cross-platform proxy checker CLI tool.

*Note* philter currently only supports HTTP proxies, SOCKS proxy support will be added in v2

## Installation
```shell
$ git clone git@github.com:seanc/philter.git
$ cd philter && mix escript.build
```

## Usage
```
Usage: philter --file [proxy file] --website [http://example.org] --timeout 100 --output working.txt

Options:
  --help    Show this message
  --file    Set proxy file (proxies should be in format "host:port")
  --website Website you want to check the proxy against (recommended: http://google.com)
  --timeout How long should we wait for the proxy to connect before we deem it unusable
  --output  The output file to write the working proxies, make sure we can write to this file
```

## Credits

|![Sean Wilson][sean-image]|
|:--------:|
| [@sean] |

## License
[MIT][license] &copy; Sean Wilson

<!-- All links must be "tagged" -->
 [@sean]: https://github.com/sean
 [sean-image]: https://avatars0.githubusercontent.com/u/13725538?v=3&s=125
 
 [license]: LICENSE