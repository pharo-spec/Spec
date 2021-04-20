Extension { #name : #SpCancelledInteractionError }

{ #category : #'*Spec2-Commander2' }
SpCancelledInteractionError >> actForSpec [
	"Does nothing on purpose."
	self flag: #TODO. "In the best world, we should delegate the behaviour to the Spec presenter which originated the error."
]
