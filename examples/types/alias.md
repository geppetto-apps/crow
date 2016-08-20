# Type aliases

```rb
alias MyNumber = Int32
```

```js
type MyNumber = number;
```

# Nilable type aliases

```rb
alias MyNumber = Int32?
```

<!-- TODO: Maybe allow ?number syntax -->

```js
type MyNumber = number | void;
```

# Union types

```rb
alias MyType = Int32 | String
```

```js
type MyType = number | string;
```

# Typed arrays

```rb
alias MyArrayType = Array(String)
```

```js
type MyArrayType = string[];
```

# Parametric types

```rb
alias MyType = Foo(Bar)
```

```js
type MyType = Foo<Bar>;
```

# Tuple type definitions

```rb
alias MyType = {Foo, Bar, Pipe}
```

```js
type MyType = [Foo, Bar, Pipe];
```

# Proc type definitions

```rb
alias FnType = Int32 -> String
```

```js
type FnType = (number): string;
```
