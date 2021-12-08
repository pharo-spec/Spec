Extension { #name : #SpGridLayout }

{ #category : #'*Spec2-Tests' }
SpGridLayout >> at: aPoint [
	
	^ childrenByPosition at: aPoint
]
