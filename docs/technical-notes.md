# Technical Notes

This document provides detailed insights into the underlying mechanisms and design decisions within the Domo library.

### Content Normalization

When appending content to an element, Domo utilizes the `Content.normalize` process powered by `@dashkite/generic`. This system automatically flattens arrays, strips null or undefined values, and safely escapes text. Raw strings are processed through the `Text.escape` utility, ensuring that any dynamically injected content is sanitized against XSS attacks before it enters the DOM. 

### Attribute Normalization

The `Attributes.normalize` function manages the complexity of HTML attributes. By leveraging `@dashkite/joy`, it collapses dashed keys efficiently. Furthermore, it handles boolean attributes; if an attribute's value is explicitly `true` or strictly matches its key, it is rendered as an empty string (the standard representation for boolean attributes in HTML). Values that are `false` or nullish are cleanly omitted from the output.

### Text Escaping

Domo leverages the browser's native capabilities to sanitize text. The `Text.escape` utility uses `Document.parseHTMLUnsafe` to parse the string safely, effectively converting problematic HTML characters into entities without risking execution of malicious scripts. This approach delegates the heavy lifting of security to the host environment, maintaining a small footprint for the library itself.

### Templating and Algorithmic Expression

Web technologies split responsibilities across three primary languages: HTML, CSS, and JavaScript. A common pattern when constructing components is to use a templating language to create HTML output. This gets at a central tension in component construction. The component structure needs to be expressed as markup, and that is the purpose of HTML. However, HTML cannot describe a process, or the algorithm with which to construct that markup.

The goal of Domo is to resolve this tension by acknowledging that we need algorithmic expression, and we should work in JavaScript. In that way, Domo is decoupled from however authors would like to create markup data structures. The focal point of Domo is the markup tree structure as expressed with nested arrays. Creators are free to construct this tree as they see fit.
