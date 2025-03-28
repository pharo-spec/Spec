Extension { #name : 'SpInvalidUserInputError' }

{ #category : '*Spec2-Commander2' }
SpInvalidUserInputError >> actForSpec [
	"Does nothing on purpose."
 
	GrowlMorph new
		contents: self messageText;
		openInWorld.
	self flag: #TODO "In the best world, we should delegate the behaviour to the Spec presenter which originated the error."
]
