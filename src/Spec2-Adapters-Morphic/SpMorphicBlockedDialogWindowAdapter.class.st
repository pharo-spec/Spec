"
I am a morphic adapter used to show a blocked dialog for a BlockedDialogWindowPresenter in Morphic.
"
Class {
	#name : #SpMorphicBlockedDialogWindowAdapter,
	#superclass : #SpMorphicDialogWindowAdapter,
	#category : #'Spec2-Adapters-Morphic-Base'
}

{ #category : #api }
SpMorphicBlockedDialogWindowAdapter >> closeOnBackdropClick [

	^ self model closeOnBackdropClick
]

{ #category : #api }
SpMorphicBlockedDialogWindowAdapter >> mouseClick: evt onBackdrop: aMorph [

	self closeOnBackdropClick ifFalse: [ ^ self ].

	self model triggerCancelAction.
	self model close. "Ensure the modal is closed"
	aMorph delete
]

{ #category : #api }
SpMorphicBlockedDialogWindowAdapter >> openWithDeferredAction: aBlock [
	"I am copying here what is defined in SystemWindow>>#openModal (but introducing the centered 
	 check inbetween because #openInWorld will use the RealEstateAgent to position the window 
	 and we want to (maybe) center it before showing it."

	self widget openInWorld.
	self presenter isCentered 
		ifTrue: [ self centered ].
	self presenter windowIsOpened.
	aBlock value.
	MorphicRenderLoop new doOneCycleWhile: [ self widget isInWorld ]
]
