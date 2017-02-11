# Functions

```crystal
def greet
  p "Hello world"
end
```

```js
function greet() {
  return console.log("Hello world");
}
```

# It differentiates between variable reads and function calls

```crystal
greeting = "Hello world"
def greet
  p greeting
end

greet
```

```js
const greeting = "Hello world";
function greet() {
  return console.log(greeting);
}

greet()
```
