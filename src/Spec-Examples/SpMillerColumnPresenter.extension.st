Extension { #name : #SpMillerColumnPresenter }

{ #category : #'*Spec-Examples' }
SpMillerColumnPresenter class >> example [
	^ SpMillerColumnPresenter new
		presenterBlock: [ :model | 
			SpListPresenter new
				items: (1 to: model);
				yourself ];
		setRootModel: 10;
		openWithSpec
]
