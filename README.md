# Domo

_Construct DOM trees programmatically in JavaScript._

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

![Domo!](https://live.staticflickr.com/162/430597485_9d320bd091_b.jpg)

```coffeescript
import H from "@dashkite/domo"

tree = H.html [
    H.body [
      H.h1 "Hello, World!"
    ]
  ]

assert.equal tree.innerHTML,
	"<html><body><h1>Hello, World!</h1></body></html>"
```

## Installation

`npm i @dashkite/domo`
