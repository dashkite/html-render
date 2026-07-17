# Reference

This document provides the API reference for the Domo library. 

## Node Builder Interface

The core of Domo's design is the node builder interface. Rather than relying on a templating engine, Domo functions as a collection of functions that programmatically assemble native DOM nodes. The core builder interface handles three primary concepts:

- **name**: The standard HTML or SVG string representing the element.
- **attributes**: A Javascript object containing properties. Domo normalizes these by collapsing dashed keys and resolving boolean attributes into standard markup formatting.
- **content**: The child elements of the node. Content is provided as nested arrays, strings, or existing nodes. Arrays are recursively flattened, nullish values are stripped, and raw strings are safely escaped against XSS attacks before injection.

By decoupling the creation of data structures from the construction of the tree, Domo allows creators to construct markup utilizing the full algorithmic expression of JavaScript.

## HTML

The `HTML` namespace exports functions for constructing standard HTML elements. To facilitate the construction of markup, Domo exposes pre-bound builder functions for all standard HTML tags directly on this namespace (e.g., `HTML.div`, `HTML.span`, `HTML.article`, `HTML.p`). These functions share the same polymorphic signature as the core `tag` builder detailed below.

```coffeescript
import { HTML } from "@dashkite/domo"

element = HTML.section { class: "hero" }, [
  HTML.h1 "Welcome"
  HTML.p "This is constructed using pre-bound standard HTML tags."
]

assert.equal element.outerHTML, '<section class="hero"><h1>Welcome</h1><p>This is constructed using pre-bound standard HTML tags.</p></section>'
```

### tag

$tag: name, attributes, content \to node$

The `tag` function serves as the foundational builder for creating a single HTML DOM element. It provides a polymorphic signature, allowing creators to omit the attributes object or content depending on the needs of the element. This function orchestrates attribute normalization and safely appends escaped child content to the new element.

```coffeescript
import { HTML } from "@dashkite/domo"

node = HTML.tag "div", { class: "container", "data-active": true }, [
  HTML.tag "span", "Hello World"
]
assert.equal node.outerHTML, '<div class="container" data-active=""><span>Hello World</span></div>'
```

### el

$el: name \to builder$

The `el` function acts as a higher-order factory that returns a specialized tag builder bound to a specific tag name. The returned builder accepts the same polymorphic arguments (`attributes` and `content`) as the underlying `tag` function. Domo uses this internally to generate the exported shorthand functions for every standard HTML tag (e.g., `HTML.div`, `HTML.span`).

```coffeescript
import { HTML } from "@dashkite/domo"

article = HTML.el "article"
node = article { id: "post-1" }, "Read more..."
assert.equal node.outerHTML, '<article id="post-1">Read more...</article>'
```

### parse

$parse: html \to [node]$

The `parse` function accepts a raw HTML string and utilizes the browser's native capabilities (`Document.parseHTMLUnsafe`) to parse the content. It returns an array of initialized DOM nodes ready to be appended to a tree.

```coffeescript
import { HTML } from "@dashkite/domo"

nodes = HTML.parse "<div>Hello</div><span>World</span>"
assert.equal nodes.length, 2
```

## SVG

The `SVG` namespace provides identical utilities for constructing Scalable Vector Graphics elements, operating symmetrically to the `HTML` namespace. Like the HTML namespace, Domo exposes pre-bound builder functions for all standard SVG tags directly on this namespace (e.g., `SVG.circle`, `SVG.path`, `SVG.rect`). These functions share the exact same polymorphic signature as the core `tag` builder.

### tag

$tag: name, attributes, content \to node$

The `tag` function constructs SVG elements. It supports the exact polymorphic signature as the HTML builder, handling SVG-specific attributes and safely appending content to a new SVG node.

```coffeescript
import { SVG } from "@dashkite/domo"

node = SVG.tag "circle", { cx: 50, cy: 50, r: 40 }
assert.equal node.outerHTML, '<circle cx="50" cy="50" r="40"></circle>'
```

### el

$el: name \to builder$

The `el` function creates a specialized tag builder for a specific SVG element name. Domo exports pre-bound functions for all standard SVG tags (e.g., `SVG.circle`, `SVG.path`) generated using this factory.

```coffeescript
import { SVG } from "@dashkite/domo"

rect = SVG.el "rect"
node = rect { width: 100, height: 100 }
assert.equal node.outerHTML, '<rect width="100" height="100"></rect>'
```

### parse

$parse: svg \to [node]$

The `parse` function parses a raw SVG string into an array of DOM nodes, functioning identically to its HTML counterpart.

```coffeescript
import { SVG } from "@dashkite/domo"

nodes = SVG.parse "<g><circle cx='10' cy='10' r='5' /></g>"
assert.equal nodes.length, 1
```
