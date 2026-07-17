# Domo

_Construct DOM trees programmatically in JavaScript._

[![Hippocratic License HL3-CORE](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-CORE&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/core.html)

Domo is a lightweight library that enables developers to construct DOM trees programmatically using simple, fluent functions. By leveraging an intuitive interface, creators can build HTML and SVG structures natively without relying on heavy templating engines.

## Features

- Constructs native DOM trees programmatically.
- Supports comprehensive HTML and SVG element generation natively.
- Safely escapes text content to mitigate XSS vulnerabilities.
- Gracefully normalizes complex HTML attributes.

## Installation

```bash
pnpm install @dashkite/domo
```

## Usage

You can build HTML trees using the exported tags. This example demonstrates how to create a simple HTML structure.

```coffeescript
import H from "@dashkite/domo"

tree = H.html [
  H.body [
    H.h1 "Hello, World!"
  ]
]

assert.equal tree.innerHTML, "<html><body><h1>Hello, World!</h1></body></html>"
```

## Other Resources

- [Reference Documentation](docs/reference.md)
- [Recipes](docs/recipes.md)
- [Technical Notes](docs/technical-notes.md)
- [Testing](docs/testing.md)
