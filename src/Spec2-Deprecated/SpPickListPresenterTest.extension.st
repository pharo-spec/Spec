Extension { #name : #SpPickListPresenterTest }

{ #category : #'*Spec2-Deprecated' }
SpPickListPresenterTest >> classToTest [
	^ SpPickListPresenter
]

{ #category : #'*Spec2-Deprecated' }
SpPickListPresenterTest class >> isDeprecated [
	"This presenter does not add enough value to Spec to be kept in it. If you are using it, please copy the code in your own application."

	^ true
]
