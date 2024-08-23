import { generic } from "@dashkite/joy/generic"
import * as Type from "@dashkite/joy/type"
import {
  createTree
  html as parse
  toString as render 
} from "diffhtml"

compact = ( array ) -> array.filter ( item ) -> item?

# convert nested object into a flat object (with scalar values)
# where the keys are formed by concatenating them with -
# ex: `foo: bar: 1` becomes `'foo-bar': 1`

flattenObject = ( prefix, object ) ->
  result = {}
  for key, value of object
    ckey = "#{ prefix }-#{ key }"
    if Type.isObject value
      Object.assign result,
        flattenObject ckey, value
    else
      result[ ckey ] = value
  result

# 'truthy' values
isValid = ( value ) -> value? && value != "" && value != false

prepare = generic name: "HTML._prepare"

generic prepare,
  Type.isObject,
  ( attributes ) ->
    result = {}
    for key, value of attributes when isValid value
      if value == true
        result[ key ] = key
      else if Type.isObject value
        Object.assign result,
          flattenObject key, value
      else
        result[ key ] = "#{ value }"
    result
      
generic prepare,
  Type.isArray,
  ( content ) -> compact content


HTML =
  parse: ( s ) -> [ parse s ]
  render: ( tree ) -> render tree

tag = generic name: "HTML.tag"

generic tag,
  Type.isString,
  ( name ) -> createTree name

generic tag,
  Type.isString,
  Type.isArray,
  ( name, content ) -> createTree name, prepare content

generic tag,
  Type.isString,
  Type.isString,
  ( name, content ) -> createTree name, content

generic tag,
  Type.isString,
  Type.isUndefined,
  ( name ) -> createTree name, ""

generic tag,
  Type.isString,
  Type.isObject,
  ( name, attributes ) -> createTree name, prepare attributes

generic tag,
  Type.isString,
  Type.isObject,
  Type.isArray,
  ( name, attributes, content ) ->  
    createTree name, 
      ( prepare attributes )
      ( prepare content )

generic tag,
  Type.isString,
  Type.isObject,
  Type.isString,
  ( name, attributes, content ) ->  
    createTree name, 
      ( prepare attributes )
      content

generic tag,
  Type.isString,
  Type.isObject,
  Type.isObject,
  ( name, attributes, content ) ->  
    createTree name, 
      ( prepare attributes ),
      [ content ]

generic tag,
  Type.isString,
  Type.isObject,
  Type.isUndefined,
  ( name, attributes ) ->  
    createTree name, 
      ( prepare attributes ),
      ""

HTML.tag = tag

el = ( name ) -> 
  ( args... ) -> tag name, args...

HTML.el = el

do ({ tag } = {}) ->
  # source: https://dev.w3.org/html5/html-author/#conforming-elements
  tags = "a abbr address area article aside audio b base bb bdo blockquote body
  br button canvas caption cite code col colgroup command datagrid datalist dd
  del details dfn dialog div dl dt em embed fieldset figure footer form h1 h2 h3
  h4 h5 h6 head header hr html i iframe img input ins kbd label legend li link
  main map mark menu meta meter nav noscript object ol optgroup option output p
  param picture pre progress q rp rt ruby samp script section select slot small source
  span strong style sub summary sup table tbody td textarea tfoot th thead time title tr
  ul var video".split " "

  for tag in tags
    HTML[ tag ] = el tag

HTML.stylesheet = ( url ) ->
  HTML.link rel: "stylesheet", href: url

SVG =
  parse: ( s ) -> [ parse s ]
  render: ( tree ) -> render tree

do ({ tag } = {}) ->
  # source: https://www.w3.org/TR/SVG2/eltindex.html
  tags = "a altGlyph altGlyphDef altGlyphItem animate animateColor animateMotion
  animateTransform animation audio canvas circle clipPath color-profile cursor
  defs desc discard ellipse feBlend feColorMatrix feComponentTransfer
  feComposite feConvolveMatrix feDiffuseLighting feDisplacementMap
  feDistantLight feDropShadow feFlood feFuncA feFuncB feFuncG feFuncR
  feGaussianBlur feImage feMerge feMergeNode feMorphology feOffset fePointLight
  feSpecularLighting feSpotLight feTile feTurbulence filter font font-face
  font-face-format font-face-name font-face-src font-face-uri foreignObject g
  glyph glyphRef handler hatch hatchpath hkern iframe image line linearGradient
  listener marker mask mesh meshgradient meshpatch meshrow metadata
  missing-glyph mpath path pattern polygon polyline prefetch radialGradient rect
  script set solidColor solidcolor stop style svg switch symbol tbreak text
  textArea textPath title tref tspan unknown use video view vkern".split " "

  for tag in tags
    SVG[tag] = el tag 

export { el, HTML, SVG }
export default HTML
