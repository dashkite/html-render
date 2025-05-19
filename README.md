# Domo

_Construct DOM trees programmatically in JavaScript._

```coffee
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
