Extension { #name : #LayoutFrame }

{ #category : #'*Spec2-Adapters-Morphic' }
LayoutFrame >> isHorizontallyResizeable [

	^ self rightFraction ~= self leftFraction
]

{ #category : #'*Spec2-Adapters-Morphic' }
LayoutFrame >> isVerticallyResizeable [

	^ self bottomFraction ~= self topFraction
]
