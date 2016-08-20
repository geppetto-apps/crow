# Converting classes

```rb
class Foo
  def initialize(@label : String)
  end
end
```

```js
class Foo {
  constructor(label : String) {
    this.label = label;
  }
}
```

# Class Inheritance

```rb
class Foo < Bar
end
```

```js
class Foo extends Bar {}
```

# Class static functions

```rb
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

```rb
Foo.new("Pipe", "Dream")
```

```js
new Foo("Pipe", "Dream");
```
