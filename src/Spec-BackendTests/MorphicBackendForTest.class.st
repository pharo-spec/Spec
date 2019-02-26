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

{ #category : #emulating }
MorphicBackendForTest >> emulateClick: mouseButtonCode onTest: anAdapterTest [ 
	| btn evt |
	"Force opening the spec instance here.
	The action should have been correctly configured before
	depending on the spec initialization strategy"
	anAdapterTest openInstance.
	
	btn := anAdapterTest adapter widget.
	evt := MouseButtonEvent new setType: nil position: btn center which: mouseButtonCode buttons: mouseButtonCode hand: nil stamp: nil.

	(btn handlesMouseDown: evt) ifTrue: [
		btn mouseDown: evt.
		btn mouseUp: evt].

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
