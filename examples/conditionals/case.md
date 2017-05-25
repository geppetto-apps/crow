# convert simple case statements

```crystal
value = "foo"
case value
when "foo"
  p "yes"
when "bar"
  p "no"
else
  p "hiyaa"
end
```

```js
var value = "foo";
switch (value) {
case "foo":
  console.log("yes");
  break;
case "bar":
  console.log("no");
  break;
default:
  console.log("hiyaa");
  break;
}
```

# Case statements without default

```crystal
value = "foo"
case value
when "foo"
  p "yes"
when "bar"
  p "no"
end
```

```js
var value = "foo";
switch (value) {
case "foo":
  console.log("yes");
  break;
case "bar":
  console.log("no");
  break;
}
```

# Case statements comparing types to if statements

```crystal
value = "foo"
case value
when Foo
  p "yes"
when Bar
  p "no"
else
  p "hiyaa"
end
```

```js
var value = "foo";
if (value instanceof Foo) {
  console.log("yes");
} else if (value instanceof Bar) {
  console.log("no");
} else {
  console.log("hiyaa");
}
```
