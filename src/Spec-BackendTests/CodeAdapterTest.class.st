Class {
	#name : #CodeAdapterTest,
	#superclass : #AbstractWidgetAdapterTestCase,
	#category : #'Spec-BackendTests'
}

{ #category : #tests }
CodeAdapterTest >> assertText: text at: index isStyle: styleName [
	| tag |

	tag := CodeStyleForTest new.
	text attributesAt: index do: [ :each | each acceptTag: tag ].
	self assert: tag equals: (self style: styleName)
]

{ #category : #tests }
CodeAdapterTest >> assertText: text atInterval: interval isStyle: styleName [

	interval do: [ :index |
		self assertText: text at: index isStyle: styleName ]
]

{ #category : #accessing }
CodeAdapterTest >> classToTest [

	^ CodePresenter
]

{ #category : #tests }
CodeAdapterTest >> style: aSymbol [ 
	| tag |
	
	tag := CodeStyleForTest new.
	self styleTableAt: aSymbol do: [ :each |
		each acceptTag: tag ]. 
	
	^ tag
	
]

{ #category : #tests }
CodeAdapterTest >> styleTableAt: styleName do: aBlock [ 
	| attributes |	

	attributes := (SHRBTextStyler initialTextAttributesForPixelHeight: 1) at: styleName.
	attributes do: aBlock
]

{ #category : #tests }
CodeAdapterTest >> testTextWithStyle [
	| text |

	presenter 
		doItReceiver: Object;
		type: 'self asString.'.
	self openInstance.
	
	text := presenter adapter textWithStyle.
	self assertText: text atInterval: "self" (1 to: 4) isStyle: #self.
	self assertText: text atInterval: "asString" (6 to: 13) isStyle: #unary.
	self assertText: text atInterval: "." (14 to: 15) isStyle: #default.	
]
