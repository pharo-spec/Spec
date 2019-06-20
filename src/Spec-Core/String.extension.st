Extension { #name : #String }

{ #category : #'*Spec-Core' }
String >> asPresenter [ 

	^ SpLabelPresenter new 
		label: self;
		yourself
]
