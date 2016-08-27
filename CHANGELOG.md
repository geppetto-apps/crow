# Change Log
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/)
and this project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]
### Added
- Version flag (-v) to CLI
- Examples in markdown (also acts as tests)

### Removed
- Internal: Removed a lot of specs now covered by markdown examples

### Fixed
- Strict flag that was broken in CLI

## [0.2.0] - 2015-08-19
### Added
- Transpile proc var assignment to function definitions
- Transpile global variables
- Transpile `self` to `this`
- Transpile type aliases
- Transpile `is_a?` to `instanceof`
- Transpile vars; bool, number and string literals explicitly
- Transpile `case/when` to `switch/case`
- Transpile `rescue` to `catch`

### Changed
- [Strict mode](https://github.com/geppetto-apps/crow/pull/6) - Enabled by default, CLI will not
  allow use of fallback transpilation, but throw an exception. Disable by
  passing `--no-strict` to the CLI.

## 0.1.0 - 2015-08-10
### Added
- Transpile `p` to `console.log`
- Transpile class structures (constructors, instance variables etc.)
- Transpile variable assignment (using let and const)
- Transpile nil
- Transpile symbols
- Transpile if, unless
- Transpile typed arrays
- Transpile hash to object

[Unreleased]: https://github.com/geppetto-apps/crow/compare/v0.2.0...HEAD
[0.2.0]: https://github.com/geppetto-apps/crow/compare/v0.1.0...v0.2.0
