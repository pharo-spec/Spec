Extension { #name : 'SystemNavigation' }

{ #category : '*Spec2-Code-Commands' }
SystemNavigation >> browse: anObject [

	anObject browse
]

{ #category : '*Spec2-Code-Commands' }
SystemNavigation >> inspect: anObject [

	(self  tools toolNamed: #inspector) inspect: anObject
]
