Extension { #name : #InteractionCancelled }

{ #category : #'*Spec2-Commander2' }
InteractionCancelled >> actForSpec [
	"Does nothing on purpose."
	self flag: #TODO. "In the best world, we should delegate the behaviour to the Spec presenter which originated the error."
]
