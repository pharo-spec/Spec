Class {
	#name : 'SpSimpleStyleProvider',
	#superclass : 'SpStyleProvider',
	#instVars : [
		'itemStyles'
	],
	#category : 'Spec2-Pillar',
	#package : 'Spec2-Pillar'
}

{ #category : 'styling' }
SpSimpleStyleProvider >> computedStylesFor: aPRDocument [ 

	itemStyles 
		at: (self itemNameFor: aPRDocument)
		ifPresent: [ :styles | ^ styles ].
	^ #()
]

{ #category : 'initialization' }
SpSimpleStyleProvider >> initialize [ 
	super initialize.
	itemStyles := Dictionary new
]

{ #category : 'accessing' }
SpSimpleStyleProvider >> itemAt: itemName put: aCollection [
	itemStyles 
		at: itemName 
		put: aCollection 
]

{ #category : 'private' }
SpSimpleStyleProvider >> itemNameFor: aDocumentItem [
	^ aDocumentItem styleName
]

{ #category : 'enumerating' }
SpSimpleStyleProvider >> keysAndValuesDo: aBlock [
	itemStyles keysAndValuesDo: aBlock
]
