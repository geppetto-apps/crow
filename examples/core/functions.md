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
greet();
```

# It can handle scopes correctly

```crystal

greeting = "Hello world"

class Greeter
  def greeting
    "Hello world"
  end
end

greeter = Greeter.new
p greeter.greeting
```

```js
const greeting = "Hello world";
class Greeter {
  greeting() {
    return "Hello world"
  }
}
const greeter = new Greeter();;
console.log(greeter.greeting(););
```

<!-- TODO: There is an extra semi-colon here -->
