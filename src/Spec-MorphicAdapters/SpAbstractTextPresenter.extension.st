Extension { #name : #SpAbstractTextPresenter }

{ #category : #'*Spec-MorphicAdapters' }
SpAbstractTextPresenter >> pendingText [
	"<api: #inspect>"
	"Return the current pending text"

	^ self 
		detectMorphicAdapterDo: [ :w | w pendingText ]
		ifNone: [ self getText ]
]

{ #category : #'*Spec-MorphicAdapters' }
SpAbstractTextPresenter >> pendingText: aText [
	"<api: #string getter: #pendingText>"
	"Set the pending text. Do no accept it"

	self 
		detectMorphicAdapterDo: [ :w | w pendingText: aText ]
		ifNone: [ self text: aText ]
]
