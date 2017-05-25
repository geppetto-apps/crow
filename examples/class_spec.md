# Converting classes

```crystal
class Foo
  def initialize(@label : String)
  end
end
```

```js
class Foo {
  constructor(label) {
    this.label = label;
  }
}
```

# Class Inheritance

```crystal
class Foo < Bar
end
```

```js
class Foo extends Bar {}
```

# Class static functions

```crystal
class Foo < Bar
  def self.pipe
  end
end
Foo.pipe
```

```js
class Foo extends Bar {
  static pipe() {}
}
Foo.pipe();
```

# Class initialization

```crystal
Foo.new("Pipe", "Dream")
```

```js
new Foo("Pipe", "Dream");
```
