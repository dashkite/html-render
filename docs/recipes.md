# Recipes

This document provides task-based scenarios demonstrating how to effectively utilize the Domo library. These recipes progress from fundamental component construction to advanced techniques for specialized elements and graphics.

## Constructing basic elements

You need to create a simple HTML element with text content.

Domo enables this by providing pre-bound functions for all standard HTML elements. You can call these functions with a string to generate a text node within the element.

```coffeescript
import H from "@dashkite/domo"

# generate a simple paragraph
element = H.p "This is a simple paragraph."
```

**Algorithm:**
1. Import the HTML builder object from Domo.
2. Invoke the specific tag function (e.g., `p`) with the desired text content.
3. The library automatically safely escapes the text and appends it to the new element.

## Building nested structures with attributes

You need to construct a nested structure of elements with specific attributes and classes.

Domo provides a polymorphic interface where you can pass an attributes object and an array of children to a tag function. This helps creators map complex data structures into DOM trees.

```coffeescript
import H from "@dashkite/domo"

# retrieve complex data
# data = fetchCreatorProfile()

element = H.div { class: "profile-card", "data-active": true }, [
  H.h2 "Creator Profile"
  H.ul [
    H.li "Name: Jane Doe"
    H.li "Role: Administrator"
  ]
]
```

**Algorithm:**
1. Call the top-level tag function, passing an object for attributes.
2. Pass an array of child elements as the second argument.
3. Nest further tag function calls within the array to build out the hierarchy.
4. Domo recursively normalizes and appends the content, returning the fully assembled parent node.

## Parsing raw HTML strings

You need to integrate a raw HTML string from an external source or legacy system into your DOM.

Domo provides a `parse` function that takes a raw HTML string and converts it into an array of initialized DOM nodes. You can then insert these nodes directly into your tree.

```coffeescript
import H from "@dashkite/domo"

# htmlString = fetchLegacyContent()

nodes = H.parse htmlString
element = H.div { class: "legacy-container" }, nodes
```

**Algorithm:**
1. Fetch the raw HTML string.
2. Pass the string to `H.parse` to generate the DOM nodes.
3. Provide the resulting nodes array as content to a parent builder function.

## Creating specialized element builders

You need to construct custom elements (such as Web Components) or elements not included in the standard HTML dictionary.

While Domo provides pre-bound functions for standard tags, you can use `H.el` to generate a dedicated builder for any custom tag name, or use `H.tag` to generate them dynamically.

```coffeescript
import H from "@dashkite/domo"

# create a reusable builder for a custom element
card = H.el "custom-card"

element = card { theme: "dark" }, [
  H.tag "custom-header", {}, "Card Title"
]
```

**Algorithm:**
1. Call `H.el` with the custom tag name to create a factory.
2. Use the returned builder function just like a standard tag function.
3. Use `H.tag` for one-off custom element generation by passing the tag name as the first argument.

## Constructing SVG graphics

You need to programmatically generate vector graphics or charts.

Domo provides a dedicated `SVG` namespace that operates symmetrically to the HTML namespace. It correctly handles the unique namespace requirements for SVG elements.

```coffeescript
import { SVG } from "@dashkite/domo"

# dimensions = calculateDimensions()

graphic = SVG.svg { width: 100, height: 100, viewBox: "0 0 100 100" }, [
  SVG.circle { cx: 50, cy: 50, r: 40, fill: "blue" }
]
```

**Algorithm:**
1. Import the `SVG` object from Domo.
2. Use standard builder functions like `svg` and `circle` to assemble the graphic.
3. Domo constructs the nodes within the proper SVG namespace, ensuring they render correctly in the browser.
