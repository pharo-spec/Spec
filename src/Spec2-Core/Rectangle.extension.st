Extension { #name : #Rectangle }

{ #category : #'*Spec2-Core' }
Rectangle >> asSpecLayoutFrame [
	"Answer an instance of LayoutFrame which uses fractions from receiver "
	
	^ SpLayoutFrame new
		leftFraction: self left;
		rightFraction: self right;
		topFraction: self top;
		bottomFraction: self bottom;
		yourself
		
]
