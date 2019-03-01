Class {
	#name : #MorphicBackendForTest,
	#superclass : #AbstractBackendForTest,
	#category : #'Spec-BackendTests'
}

{ #category : #asserting }
MorphicBackendForTest >> assertHasHeader: aFTTableMorph [ 

	| tableContainer |
	World doOneCycle.

	tableContainer := aFTTableMorph submorphs first.
	self assert: tableContainer submorphs size = 3
]

{ #category : #asserting }
MorphicBackendForTest >> assertIcon: anAlphaImageMorph equals: aForm [ 
	
	self assert: (anAlphaImageMorph ifNotNil: #form) = aForm
]

{ #category : #asserting }
MorphicBackendForTest >> assertList: aFTTableMorph displayItems: aCollection [ 
	
	| tableContainer tableRowContents |
	
	World doOneCycle.
	World doOneCycle.
	World doOneCycle.
	
	tableContainer := aFTTableMorph submorphs first.
	tableRowContents := tableContainer submorphs collect: [ :row | 
		| cell |
		cell := row submorphs first.
		cell submorphs first contents ].
	
	self assert: tableRowContents first = aCollection first.
	self assert: tableRowContents second = aCollection second.
	self assert: tableRowContents third = aCollection third.
]

{ #category : #asserting }
MorphicBackendForTest >> assertListHeaderOf: aFTTableMorph equals: aCollection [ 

	| tableContainer tableRowMorph cells |
	
	World doOneCycle.
	World doOneCycle.
	World doOneCycle.
	
	tableContainer := aFTTableMorph submorphs first.
	tableRowMorph := tableContainer submorphs first.
	cells := tableRowMorph submorphs.
	
	self assert: (cells collect: [ :c | c submorphs first contents]) asArray = aCollection asArray
]

{ #category : #testing }
MorphicBackendForTest >> canChangeFonts [
	
	^ true
]

{ #category : #emulating }
MorphicBackendForTest >> clickFirstRowAndColumn: aFTTableMorph [ 

	World doOneCycle.
	World doOneCycle.
	World doOneCycle.
	
	aFTTableMorph mouseDown: (MouseEvent new
		setHand: HandMorph new;
		setPosition: aFTTableMorph submorphs first submorphs first bounds center;
		yourself).

]

{ #category : #simulating }
MorphicBackendForTest >> doubleClickFirstRowAndColumn: aFTTableMorph [ 

	World doOneCycle.
	World doOneCycle.
	World doOneCycle.

	aFTTableMorph doubleClick: (MouseEvent new
		setPosition: aFTTableMorph submorphs first submorphs first bounds center;
		yourself).

]

{ #category : #opening }
MorphicBackendForTest >> openInstanceOf: aTest [ 

	aTest window ifNil: [ aTest window: aTest presenter openWithSpec ].
	World doOneCycle.
]

{ #category : #running }
MorphicBackendForTest >> runTest: aBlockClosure [ 
	
	aBlockClosure value
]
