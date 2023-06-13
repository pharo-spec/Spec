Class {
	#name : #SpCodeAdapterTest,
	#superclass : #SpTextAdapterTest,
	#category : #'Spec2-Code-Backend-Tests'
}

{ #category : #tests }
SpCodeAdapterTest >> assertText: text at: index isStyle: styleName [
	| tag |

	tag := SpCodeStyleForTest new.
	text attributesAt: index do: [ :each | 
		self fillTag: tag withAttribute: each ].
	self assert: tag equals: (self style: styleName)
]

{ #category : #tests }
SpCodeAdapterTest >> assertText: text atInterval: interval isStyle: styleName [

	interval do: [ :index |
		self assertText: text at: index isStyle: styleName ]
]

{ #category : #accessing }
SpCodeAdapterTest >> classToTest [

	^ SpCodePresenter
]

{ #category : #tests }
SpCodeAdapterTest >> fillTag: tag withAttribute: attr [

	attr class = TextColor ifTrue: [ tag foreground: attr color ].
	self flag: #TODO. "Other attributes"
]

{ #category : #tests }
SpCodeAdapterTest >> style: aSymbol [ 
	| tag |
	
	tag := SpCodeStyleForTest new.
	self styleTableAt: aSymbol do: [ :each |
		self fillTag: tag withAttribute: each ]. 
	
	^ tag
	
]

{ #category : #tests }
SpCodeAdapterTest >> styleTableAt: styleName do: aBlock [ 
	| attributes |	

	attributes := SHRBTextStyler initialTextAttributes at: styleName.
	attributes do: aBlock
]

{ #category : #accessing }
SpCodeAdapterTest >> testRightClickShowsMenu [
	| menu |

	presenter 
		contextMenu: (menu := SpMockMenuPresenter new);
		overrideContextMenu: true.

	self deny: menu shown.
	self emulateRightClick.
	self assert: menu shown
]

{ #category : #tests }
SpCodeAdapterTest >> testTextWithStyle [

	| text |
	presenter
		beForObject: Object;
		text: 'self asString.'.

	text := self adapter textWithStyle.
	self assertText: text atInterval: (1 to: 4) isStyle: #self. "self"
	self assertText: text atInterval: (6 to: 13) isStyle: #selector. "asString"

	presenter type: '10 + 42.0'.
	text := self adapter textWithStyle.
	self assertText: text atInterval: (1 to: 2) isStyle: #number. "10"
	self assertText: text atInterval: (4 to: 4) isStyle: #selector. "+"
	self assertText: text atInterval: (6 to: 9) isStyle: #number. "42.0"

	presenter beForBehavior: Object.
	presenter type: 'm1 ^ "test" 42'.
	text := self adapter textWithStyle.
	self assertText: text atInterval: (1 to: 2) isStyle: #patternSelector. "m1"
	self assertText: text atInterval: (4 to: 4) isStyle: #return. "^"
	self assertText: text atInterval: (6 to: 11) isStyle: #comment. "test"
	self assertText: text atInterval: (13 to: 14) isStyle: #number "42"
]

{ #category : #tests }
SpCodeAdapterTest >> testWithSyntaxHighlight [
	presenter withSyntaxHighlight.
	self assert: self adapter hasSyntaxHighlightEnabled
]

{ #category : #tests }
SpCodeAdapterTest >> testWithoutSyntaxHighlight [
	presenter withoutSyntaxHighlight.
	self deny: self adapter hasSyntaxHighlightEnabled
]
