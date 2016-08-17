[![Build Status](http://ci.geppetto.no/api/badges/geppetto-apps/crow/status.svg)](http://ci.geppetto.no/geppetto-apps/crow)
[![Dependency Status](https://shards.rocks/badge/github/geppetto-apps/crow/status.svg)](https://shards.rocks/github/geppetto-apps/crow)
[![devDependency Status](https://shards.rocks/badge/github/geppetto-apps/crow/dev_status.svg)](https://shards.rocks/github/geppetto-apps/crow)

# crow

`crow` transpiles [Crystal][cr] source code to valid [Flow][flow]/ES2015/JavaScript).

Code that is transpiled to valid Flow syntax may be transpiled to valid ES2015,
which may be transpiled to Javascript (via [Babel][babel]).

## Warning: Experimental

This project is in alpha stage and should be considered highly experimental.

## Installation

Via [Homebrew][brew]:

```
brew install geppetto-apps/bin/crow
```

Via [npm][npm]:

```
npm install crow-cli -g
```

## Usage

```sh
# Compiles and outputs to foo.js.flow
$ crow foo.cr

# Same as above
$ cat foo.cr | crow > foo.js.flow

# Compile to JavaScript (via Babel)
$ npm install babel-preset-es2015 babel-plugin-transform-flow-strip-types
$ cat foo.cr | crow | babel --plugins transform-flow-strip-types --presets es2015
```

You can also use [Docker][docker]:

```sh
$ cat foo.cr | docker run -i geppetto-apps/crow > foo.js.flow
```

## Development

You need to have a copy of the [Crystal source code][cr-src] sitting in a directory
next to `crow`.

## Supported AST nodes

Extracted from [Crystal's compiler][cr-parser].

- [x] Expressions
- [x] NilLiteral
- [x] BoolLiteral
- [x] NumberLiteral
- [x] CharLiteral
- [x] StringLiteral
- [x] StringInterpolation
- [x] SymbolLiteral
- [x] ArrayLiteral
- [x] HashLiteral
- [x] NamedTupleLiteral
- [ ] ProcLiteral
- [ ] RangeLiteral
- [ ] RegexLiteral
- [ ] TupleLiteral
- [x] Var
- [x] Block
- [x] Call
- [ ] NamedArgument
- [x] If
- [x] Unless
- [ ] IfDef
- [x] Assign
- [ ] MultiAssign
- [x] InstanceVar
- [ ] ReadInstanceVar
- [ ] ClassVar
- [x] Global
- [ ] BinaryOp
- [ ] Arg
- [x] ProcNotation
- [x] Def
- [ ] Macro
- [ ] UnaryExpression
- [ ] VisibilityModifier
- [ ] IsA
- [ ] RespondsTo
- [ ] Require
- [ ] When
- [ ] Case
- [ ] ImplicitObj
- [ ] Path
- [ ] While
- [ ] Until
- [ ] Generic
- [ ] TypeDeclaration
- [ ] UninitializedVar
- [x] Rescue
- [x] ExceptionHandler
- [ ] ProcPointer
- [ ] Union
- [x] Self
- [ ] ControlExpression
- [ ] Yield
- [ ] Include
- [ ] Extend
- [ ] EnumDef
- [x] ClassDef
- [ ] ModuleDef
- [ ] LibDef
- [ ] FunDef
- [ ] TypeDef
- [ ] CStructOrUnionDef
- [ ] ExternalVar
- [x] Alias
- [ ] Metaclass
- [ ] Cast
- [ ] NilableCast
- [ ] TypeOf
- [ ] Attribute
- [ ] MacroExpression
- [ ] MacroIf
- [ ] MacroFor
- [ ] MacroVar
- [ ] MacroLiteral
- [ ] Underscore
- [ ] MagicConstant
- [ ] Asm
- [ ] AsmOperand

## Contributing

1. Fork it ( https://github.com/geppetto-apps/crow/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [theodorton](https://github.com/theodorton) Theodor Tonum - creator, maintainer

[cr]: https://crystal-lang.org/
[cr-src]: https://github.com/crystal-lang/crystal
[cr-syntax]: https://github.com/crystal-lang/crystal/blob/master/src/compiler/crystal/syntax/ast.cr
[docker]: https://www.docker.com/
[flow]: https://flowtype.org/
[babel]: https://babeljs.io/
[npm]: https://www.npmjs.com
[brew]: http://brew.sh/
