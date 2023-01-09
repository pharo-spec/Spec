Extension { #name : #Morph }

{ #category : #'*Spec2-Morphic' }
Morph >> asPresenterOn: aPresenter [

	^ aPresenter newMorph
		morph: self;
		yourself
]
