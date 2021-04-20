"
Font property (`SpStyleFont`)

Font properties control how a component (morph) with font will draw the text.
I keep this properties: 

- name: The font name (it needs to be available in the list of fonts, e.g. ""Source Code Pro"") 
- size: The font point size.
- bold: Font is bold? (boolean, default """"false"""")
- italic: Font is italic? (boolean, default """"false"""")

## Usage
The identifier of font in the stylesheet is _Font_.

```language=Javascript
Font { 
 	#name: ""Source Sans Pro"",  
	#size: 12,
	#bold: false,
	#italic: false
}
```

## Predefined fonts
User can also point to the fonts pre-defined (comming from Settings).
To do that, is enough to access the property `predefinedFont`, and value can be one of the list: 

- `#default`
- `#code`
- `#ballon`
- `#button`
- `#halo`
- `#list`
- `#menu`

**NOTE:** Using `predefinedFont` will meke any other Font property defined to be ignored.

```language=Javascript
Font { 
 	#predefinedFont: #code
}
```

"
Class {
	#name : #SpStyleFont,
	#superclass : #SpFontStyle,
	#category : #'Spec2-Adapters-Morphic-StyleSheet'
}

{ #category : #testing }
SpStyleFont class >> isDeprecated [ 
	^ true
]
