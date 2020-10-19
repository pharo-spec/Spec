Class {
	#name : #SpMorphicPaginatorAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#instVars : [
		'backendUpdating'
	],
	#category : #'Spec2-Morphic-Paginator'
}

{ #category : #private }
SpMorphicPaginatorAdapter >> backendDetectCyclesDo: aBlock [ 

	self isBackendUpdating ifTrue: [ ^ self ].
	^ aBlock value
]

{ #category : #private }
SpMorphicPaginatorAdapter >> backendUpdatingDo: aBlock [ 
	| oldStatus |

	oldStatus := backendUpdating.
	backendUpdating := true.
	aBlock ensure: [ 
		backendUpdating := oldStatus ]
]

{ #category : #factory }
SpMorphicPaginatorAdapter >> buildWidget [
	| morph |
	
	morph := SpPaginatorMorph new
		addPages: self presenter pages;
		yourself.
	self presenter whenSelectedPageChangedDo: [ :aNumber |
		self backendDetectCyclesDo: [ 
				morph selectPage: aNumber ] ].
	morph whenSelectedPageChangedDo: [ :aNumber |
		self backendUpdatingDo: [ 
			self presenter selectPage: aNumber  ]  ].
	self presenter whenVisiblePagesChangedDo: [ :aNumber |
		morph numberOfPagesShown: aNumber ].
	self presenter whenPageAddedDo: [ :anObject | 
		morph addPage: anObject ].
	self presenter whenPageRemovedDo: [ :anObject |
		self halt ].
	
	^ morph
]

{ #category : #initialization }
SpMorphicPaginatorAdapter >> initialize [

	super initialize.
	backendUpdating := false
]

{ #category : #private }
SpMorphicPaginatorAdapter >> isBackendUpdating [

	^ backendUpdating
]
