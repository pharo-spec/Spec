Extension { #name : 'CmUICommandGroupDisplayStrategy' }

{ #category : '*Spec2-Commander2' }
CmUICommandGroupDisplayStrategy >> display: aCmSpecCommandGroup in: aMenuPresenter do: aBlock [
	self subclassResponsibility
]

{ #category : '*Spec2-Commander2' }
CmUICommandGroupDisplayStrategy >> isGroup [

	self subclassResponsibility
]

{ #category : '*Spec2-Commander2' }
CmUICommandGroupDisplayStrategy >> isSubMenu [

	^ self isGroup not
]
