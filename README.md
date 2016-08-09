[![Build Status](http://ci.geppetto.no/api/badges/geppetto-apps/cr2flow/status.svg)](http://ci.geppetto.no/geppetto-apps/cr2flow)
[![Dependency Status](https://shards.rocks/badge/github/geppetto-apps/cr2flow/status.svg)](https://shards.rocks/github/geppetto-apps/cr2flow)
[![devDependency Status](https://shards.rocks/badge/github/geppetto-apps/cr2flow/dev_status.svg)](https://shards.rocks/github/geppetto-apps/cr2flow)

# cr2flow

`cr2flow` transpiles [Crystal][cr] source code to valid [Flow][flow]/ES2015/JavaScript).

Code that is transpiled to valid Flow syntax may be transpiled to valid ES2015,
which may be transpiled to Javascript (via [Babel][babel]).

## Installation

TODO: Publish with homebrew

## Usage

```sh
# Compiles and outputs to foo.js.flow
$ cr2flow foo.cr

# Compiles and outputs to foo.js (flow must be installed)
$ cr2flow --emit es6 foo.cr
```

## Development

You need to have a copy of the [Crystal source code][cr-src] sitting in a directory
next to `cr2flow`.

## Contributing

1. Fork it ( https://github.com/geppetto-apps/cr2flow/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [theodorton](https://github.com/theodorton) Theodor Tonum - creator, maintainer

[cr]: https://crystal-lang.org/
[cr-src]: https://github.com/crystal-lang/crystal
[flow]: https://flowtype.org/
[babel]: https://babeljs.io/
