# convert normal unless

```crystal
unless true
  p "yes"
end
```

```js
if (!true) {
  console.log("yes");
}
```

# convert unless and else

```crystal
unless true
  p "yes"
else
  p "no"
end
```

```js
if (!true) {
  console.log("yes");
} else {
  console.log("no");
}
```
