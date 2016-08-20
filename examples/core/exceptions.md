# Begin/rescue blocks

```rb
begin
  raise "This is an exception."
rescue e
  p "This block rescues the exception"
end
```

```js
try {
  throw new Error("This is an exception.");
} catch (e) {
  console.log("This block rescues the exception");
}
```

# Keep named exception vars

```rb
begin
  raise "This is an exception."
rescue ex
  p ex
end
```

```js
try {
  throw new Error("This is an exception.");
} catch (e) {
  const ex = e;
  console.log(ex);
}
```

# Ensure/finally

```rb
begin
  raise "This is an exception."
rescue e
  p "This block rescues the exception"
ensure
  p "This block always run"
end
```

```js
try {
  throw new Error("This is an exception.");
} catch (e) {
  console.log("This block rescues the exception");
} finally {
  console.log("This block always run");
}
```

# Specific exception handlers

```rb
begin
  function_accessing_array()
rescue iex : IndexError
  p "We got an index error:", iex
rescue ex : Exception | ArgumentError
  p "Default exception or argument error"
end
```

```js
try {
  function_accessing_array();
} catch (e) {
  if (e instanceof IndexError) {
    const iex = e;
    console.log("We got an index error:", iex);
  } else if (e instanceof Exception || e instanceof ArgumentError) {
    const ex = e;
    console.log("Default exception or argument error");
  }
}
```
