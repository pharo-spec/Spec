Extension { #name : 'SpInvalidUserInputError' }

{ #category : '*Spec2-Commander2' }
SpInvalidUserInputError >> actForSpec [
	"Does nothing on purpose."

	SpInformDialog new
		label: self messageText;
		openDialog.
	self flag: #TODO "In the best world, we should delegate the behaviour to the Spec presenter which originated the error."
]
