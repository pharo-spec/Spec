Extension { #name : #LayoutFrame }

{ #category : #'*Spec2-Pharo7To8Compatibility' }
LayoutFrame >> isHorizontallyResizeable [

	^ self rightFraction ~= self leftFraction
]

{ #category : #'*Spec2-Pharo7To8Compatibility' }
LayoutFrame >> isVerticallyResizeable [

	^ self bottomFraction ~= self topFraction
]
