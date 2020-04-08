Class {
	#name : #PRSimpleStyleProvider,
	#superclass : #PRStyleProvider,
	#instVars : [
		'itemStyles'
	],
	#category : #'Spec2-Pillar'
}

{ #category : #'as yet unclassified' }
PRSimpleStyleProvider >> computedStylesFor: aPRDocument [ 

	itemStyles 
		at: (self itemNameFor: aPRDocument)
		ifPresent: [ :styles | ^ styles ].
	^ #()
]

{ #category : #initialization }
PRSimpleStyleProvider >> initialize [ 
	super initialize.
	itemStyles := Dictionary new
]

{ #category : #accessing }
PRSimpleStyleProvider >> itemAt: itemName put: aCollection [
	itemStyles 
		at: itemName 
		put: aCollection 
]

{ #category : #'as yet unclassified' }
PRSimpleStyleProvider >> itemNameFor: aDocumentItem [
	^ aDocumentItem styleName
]

{ #category : #'as yet unclassified' }
PRSimpleStyleProvider >> keysAndValuesDo: aBlock [
	itemStyles keysAndValuesDo: aBlock
]
