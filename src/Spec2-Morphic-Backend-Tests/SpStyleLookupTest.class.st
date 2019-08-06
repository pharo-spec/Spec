Class {
	#name : #SpStyleLookupTest,
	#superclass : #TestCase,
	#category : #'Spec2-Morphic-Backend-Tests'
}

{ #category : #private }
SpStyleLookupTest >> newLookup: aString [
	| rootClass |

	rootClass := SpStyleSTONReader fromString: aString.
	^ SpStyleLookup newStyles: rootClass flattenClasses 
]

{ #category : #tests }
SpStyleLookupTest >> testApplyTo [
	| styleResolver morph |
	
	styleResolver := self newLookup: '.application [ 
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

	morph := Morph new.
	styleResolver applyTo: morph.
	self assert: morph width equals: 42
]

{ #category : #tests }
SpStyleLookupTest >> testDeepLookup [
	"This should answer the deepest width"
	| styleResolver |
	
	styleResolver := self newLookup: '.application [ 
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
SpStyleLookupTest >> testDeepMultipleLookup [
	"This should answer the deepest width (last appearence)"
	| styleResolver |
	
	styleResolver := self newLookup: '.application [ 
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
SpStyleLookupTest >> testFromStylesheetAdapter [
	| lookup labelAdapter |

	labelAdapter := SpLabelPresenter new 
		buildWithSpec;
		adapter.

	lookup := SpStyleLookup
		fromStylesheet: (SpStyleSTONReader fromString: '
.application [
	.label [
		Geometry { #width: 42 }
		]
	]')
		adapter: labelAdapter.
		
	self assert: lookup width equals: 42.
	
	lookup := SpStyleLookup
		fromStylesheet: (SpStyleSTONReader fromString: '
.application [
	Geometry { #width: 42 },
	.label [ ]
	]')
		adapter: labelAdapter.
	self assert: lookup width equals: 42.
	
	"it refuses deeper class (because is not part of the tree)"
	lookup := SpStyleLookup
		fromStylesheet: (SpStyleSTONReader fromString: '
.application [
	.label [
		Geometry { #width: 42 }
	],
	.other [ 
		.label [ 
			Geometry { #width: 22 } 
		] 
	]
]')
		adapter: labelAdapter.

]

{ #category : #tests }
SpStyleLookupTest >> testSimpleLookup [
	"this should answer the width defined in the only level"
	| styleResolver |
	
	styleResolver := self newLookup: '.application [ 
		Geometry { #width: 42 } 
	]'.

	self assert: styleResolver width equals: 42
]
