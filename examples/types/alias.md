# Type aliases

```crystal
alias MyNumber = Int32
```

```js
type MyNumber = number;
```

# Nilable type aliases

```crystal
alias MyNumber = Int32?
```

<!-- TODO: Maybe allow ?number syntax -->

```js
type MyNumber = number | void;
```

# Union types

```crystal
alias MyType = Int32 | String
```

```js
type MyType = number | string;
```

# Typed arrays

```crystal
alias MyArrayType = Array(String)
```

```js
type MyArrayType = string[];
```

# Parametric types

```crystal
alias MyType = Foo(Bar)
```

```js
type MyType = Foo<Bar>;
```

# Tuple type definitions

```crystal
alias MyType = {Foo, Bar, Pipe}
```

```js
type MyType = [Foo, Bar, Pipe];
```

# Proc type definitions

```crystal
alias FnType = Int32 -> String
```

```js
type FnType = (number): string;
```
