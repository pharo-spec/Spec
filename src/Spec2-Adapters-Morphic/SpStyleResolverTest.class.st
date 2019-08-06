Class {
	#name : #SpStyleResolverTest,
	#superclass : #TestCase,
	#category : #'Spec2-Adapters-Morphic-StyleSheet'
}

{ #category : #private }
SpStyleResolverTest >> newStyleResolver: aString [
	| rootClass |

	rootClass := SpStyleSTONReader fromString: aString.
	^ SpStyleResolver newStyles: rootClass flattenClasses 
]

{ #category : #tests }
SpStyleResolverTest >> testDeepLookup [
	"This should answer the deepest width"
	| styleResolver |
	
	styleResolver := self newStyleResolver: '.application [ 
		Geometry { #width: 11 },
		.other [
			Geometry { #width: 22 },
			.deep [
				Geometry { #width: 42 }
			]
		]
	]'.

	self assert: styleResolver width equals: 42
]

{ #category : #tests }
SpStyleResolverTest >> testDeepMultipleLookup [
	"This should answer the deepest width (last appearence)"
	| styleResolver |
	
	styleResolver := self newStyleResolver: '.application [ 
		Geometry { #width: 11 },
		.other [
			Geometry { #width: 22 },
			.deep1 [
				Geometry { #width: 33 }
			],
			.deep2 [
				Geometry { #width: 42 }
			]
		]
	]'.

	self assert: styleResolver width equals: 42
]

{ #category : #tests }
SpStyleResolverTest >> testSimpleLookup [
	"this should answer the width defined in the only level"
	| styleResolver |
	
	styleResolver := self newStyleResolver: '.application [ 
		Geometry { #width: 42 } 
	]'.

	self assert: styleResolver width equals: 42
]
