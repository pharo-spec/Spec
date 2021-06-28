Extension { #name : #Symbol }

{ #category : #'*Spec2-Core' }
Symbol >> asPresenterOn: aPresenter [

	^ aPresenter presenterAt: self
]
