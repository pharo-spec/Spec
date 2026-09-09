Extension { #name : 'SystemNavigation' }

{ #category : '*Spec2-Code-Commands' }
SystemNavigation >> browse: anObject [

	anObject browse
]

{ #category : '*Spec2-Code-Commands' }
SystemNavigation >> browseAllSendersOf: aVariableOrClassName from: aContext [

	(Smalltalk tools toolNamed: #messageList)
		browseSendersOfAll: { aVariableOrClassName } 
		from: aContext
]

{ #category : '*Spec2-Code-Commands' }
SystemNavigation >> inspect: anObject [

	(self  tools toolNamed: #inspector) inspect: anObject
]
