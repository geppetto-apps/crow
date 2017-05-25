# Hello World

```crystal
p "Hello World"
```

```js
console.log("Hello World");
```

# String assignment

```crystal
text = "Hello World"
p text
```

```js
var text = "Hello World";
console.log(text);
```

# String assignment (var)

```crystal
text = "Hello"
text += " "
text += "World"
p text
```

```js
var text = "Hello";
text = text + " ";
text = text + "World";
console.log(text);
```

# Concatenating strings

```crystal
p "Hello" + "World"
```

```js
console.log("Hello" + "World");
```

# Interpolated string

```crystal
who = "World"
p "Hello #{who}"
```

```js
var who = "World";
console.log(`Hello ${who}`);
```

# Arithmetic operations
<!-- TODO: Move this -->

```crystal
p 512 * 16 + 24 - 12
```

```js
console.log((512 * 16) + 24 - 12);
```
