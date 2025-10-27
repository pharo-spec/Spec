Extension { #name : 'CmCommandAborted' }

{ #category : '*Spec2-Commander2' }
CmCommandAborted >> actForSpec [
	application inform: ('"{1}" command was aborted because: {2}' format: { self command name . self reason })
		
]

{ #category : '*Spec2-Commander2' }
CmCommandAborted >> application: anApplication [

	application := anApplication
]
