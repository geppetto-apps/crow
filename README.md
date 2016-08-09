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

# Same as above
$ cat foo.cr | cr2flow > foo.js.flow

# Compile to JavaScript (via Babel)
$ npm install babel-preset-es2015 babel-plugin-transform-flow-strip-types
$ cr2flow foo.cr |  babel --plugins transform-flow-strip-types --presets es2015
```

You can also use [Docker][docker]:

```sh
$ cat foo.cr | docker run -i geppetto-apps/cr2flow > foo.js.flow
```

## Development

You need to have a copy of the [Crystal source code][cr-src] sitting in a directory
next to `cr2flow`.

## Supported AST nodes

Extracted from [Crystal's compiler][cr-parser].

- [x] Expressions
- [ ] NilLiteral
- [ ] BoolLiteral
- [ ] NumberLiteral
- [ ] CharLiteral
- [x] StringLiteral
- [x] StringInterpolation
- [ ] SymbolLiteral
- [ ] ArrayLiteral
- [ ] HashLiteral
- [ ] NamedTupleLiteral
- [ ] RangeLiteral
- [ ] RegexLiteral
- [ ] TupleLiteral
- [ ] Var
- [ ] Block
- [x] Call
- [ ] NamedArgument
- [ ] If
- [ ] Unless
- [ ] IfDef
- [x] Assign
- [ ] MultiAssign
- [ ] InstanceVar
- [ ] ReadInstanceVar
- [ ] ClassVar
- [ ] Global
- [ ] BinaryOp
- [ ] Arg
- [ ] ProcNotation
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
- [x] ClassDef
- [ ] ModuleDef
- [ ] While
- [ ] Until
- [ ] Generic
- [ ] TypeDeclaration
- [ ] UninitializedVar
- [ ] Rescue
- [ ] ExceptionHandler
- [ ] ProcLiteral
- [ ] ProcPointer
- [ ] Union
- [ ] Self
- [ ] ControlExpression
- [ ] Yield
- [ ] Include
- [ ] Extend
- [ ] LibDef
- [ ] FunDef
- [ ] TypeDef
- [ ] CStructOrUnionDef
- [ ] EnumDef
- [ ] ExternalVar
- [ ] Alias
- [ ] Metaclass
- [ ] Cast
- [ ] NilableCast
- [ ] TypeOf
- [ ] Attribute
- [ ] MacroExpression
- [ ] MacroLiteral
- [ ] MacroIf
- [ ] MacroFor
- [ ] MacroVar
- [ ] Underscore
- [ ] MagicConstant
- [ ] Asm
- [ ] AsmOperand

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
[cr-syntax]: https://github.com/crystal-lang/crystal/blob/master/src/compiler/crystal/syntax/ast.cr
[docker]: https://www.docker.com/
[flow]: https://flowtype.org/
[babel]: https://babeljs.io/
