Class {
	#name : #SpSimpleStyleProvider,
	#superclass : #SpStyleProvider,
	#instVars : [
		'itemStyles'
	],
	#category : #'Spec2-Pillar'
}

{ #category : #'as yet unclassified' }
SpSimpleStyleProvider >> computedStylesFor: aPRDocument [ 

	itemStyles 
		at: (self itemNameFor: aPRDocument)
		ifPresent: [ :styles | ^ styles ].
	^ #()
]

{ #category : #initialization }
SpSimpleStyleProvider >> initialize [ 
	super initialize.
	itemStyles := Dictionary new
]

{ #category : #accessing }
SpSimpleStyleProvider >> itemAt: itemName put: aCollection [
	itemStyles 
		at: itemName 
		put: aCollection 
]

{ #category : #'as yet unclassified' }
SpSimpleStyleProvider >> itemNameFor: aDocumentItem [
	^ aDocumentItem styleName
]

{ #category : #'as yet unclassified' }
SpSimpleStyleProvider >> keysAndValuesDo: aBlock [
	itemStyles keysAndValuesDo: aBlock
]
