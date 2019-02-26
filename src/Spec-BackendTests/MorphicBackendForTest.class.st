Class {
	#name : #MorphicBackendForTest,
	#superclass : #AbstractBackendForTest,
	#category : #'Spec-BackendTests'
}

{ #category : #asserting }
MorphicBackendForTest >> assertIcon: anAlphaImageMorph equals: aForm [ 
	
	self assert: anAlphaImageMorph form = aForm
]

{ #category : #testing }
MorphicBackendForTest >> canChangeFonts [
	
	^ true
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
