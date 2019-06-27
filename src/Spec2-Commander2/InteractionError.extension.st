Extension { #name : #InteractionError }

{ #category : #'*Spec2-Commander2' }
InteractionError >> actForSpec [
	"Override this method to define the behaviour of when an interaction error occurs."
	self subclassResponsibility
]
