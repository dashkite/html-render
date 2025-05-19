import Generic from "@dashkite/generic"
import * as Fn from "@dashkite/joy/function"
import * as Obj from "@dashkite/joy/object"


nil = ( x ) -> !x?
renderable = ( x ) -> x.toString?

Attributes = 

  normalize: ( attributes ) ->
    result = {}
    for key, value of Obj.collapse delimiter: "-", attributes
      if ( value == true ) || ( value == key ) || ( value == "" )
        result[ key ] = ""
      else if ( value? ) && ( value != "" ) && ( value != false )
        result[ key ] = value
    result

Text =
  # This preserves treatment of HTML entities and other
  # oddities of HTML formatting, while de facto escaping
  # any HTML tags...
  escape: ( text ) ->
    Document
      .parseHTMLUnsafe text
      .body
      .innerHTML

Content =

  normalize: do ->
    
    ( Generic.make "<private> Content.normalize" )
    
      .define [ Array ], ( values ) ->
        ( Content.normalize value ) for value in values when value?
      .define [ Node ], Fn.identity
      .define [ String ], Text.escape


HTML =
  parse: ( html ) -> 
    Array.from do ->
      Document
        .parseHTMLUnsafe html
        .body
        .children

  tag: tag = do ->

    ( Generic.make "tag" )

      .define [ String ], ( name ) -> 
        tag name, {}, []

      .define [ String, renderable ], ( name, content ) ->
        tag name, {}, content.toString()

      .define [ String, nil ], ( name, content ) ->
        tag name, {}, []

      .define [ String, Object ], ( name, attributes ) ->
        tag name, attributes, []

      .define [ String, Array ], ( name, content ) -> 
        tag name, {}, content

      .define [ String, String ], ( name, content ) ->
        tag name, {}, [ content ]

      .define [ String, Node ], ( name, content ) ->
        tag name, {}, [ content ]

      .define [ String, Object, renderable ], ( name, attributes, content ) ->
        tag name, attributes, content.toString()

      .define [ String, Object, nil ], ( name, attributes, content ) ->
        tag name, attributes, []

      .define [ String, Object, String ], ( name, attributes, content ) ->
        tag name, attributes, [ content ]

      .define [ String, Object, Node ], ( name, attributes, content ) ->
        tag name, attributes, [ content ]

      .define [ String, Object, Array ], ( name, attributes, content ) -> 
        element = document.createElement name
        for key, value of ( Attributes.normalize attributes )
          element.setAttribute key, value
        element.replaceChildren ( Content.normalize content )...
        element

  el: ( name ) -> 
    ( args... ) -> HTML.tag name, args...

do ({ tag } = {}) ->
  # source: https://dev.w3.org/html5/html-author/#conforming-elements
  tags = "a abbr address area article aside audio b base bb bdo blockquote body
  br button canvas caption cite code col colgroup command datagrid datalist dd
  del details dfn dialog div dl dt em embed fieldset figure footer form h1 h2 h3
  h4 h5 h6 head header hr html i iframe img input ins kbd label legend li link
  main map mark menu meta meter nav noscript object ol optgroup option output p
  param picture pre progress q rp rt ruby samp script section select slot small source
  span strong style sub summary sup svg table tbody td textarea tfoot th thead time title tr
  ul var video".split " "

  for tag in tags
    HTML[ tag ] = HTML.el tag

SVG =
  parse: HTML.parse

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
    SVG[tag] = HTML.el tag 



export { HTML, SVG }
export default HTML
