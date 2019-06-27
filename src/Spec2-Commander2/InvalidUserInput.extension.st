Extension { #name : #InvalidUserInput }

{ #category : #'*Spec2-Commander2' }
InvalidUserInput >> actForSpec [
	"Does nothing on purpose."
	UIManager default
		inform: self messageText.
	self flag: #TODO "In the best world, we should delegate the behaviour to the Spec presenter which originated the error."
]
