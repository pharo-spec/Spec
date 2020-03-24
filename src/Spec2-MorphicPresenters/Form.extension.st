Extension { #name : #Form }

{ #category : #'*Spec2-MorphicPresenters' }
Form >> asPresenter [

	^ SpImagePresenter new 
		image: self;
		yourself
]
