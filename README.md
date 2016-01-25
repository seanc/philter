philter
============
> A cross-platform proxy checker CLI tool.

## Installation
```shell
$ git clone git@github.com:seanc/philter.git
$ cd philter && mix escript.build
```

## Usage
```shell
Usage: philter --file [proxy file] --website [http://example.org]

Options:
  --help    Show this message
  --file    Set proxy file (proxies should be in format "host:port")
  --website Website you want to check the proxy against (recommended: http://google.com)
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