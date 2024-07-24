Extension { #name : 'SpTPresenterBuilder' }

{ #category : '*Spec2-ListView' }
SpTPresenterBuilder >> newDropDown [

	^ self instantiate: SpDropDownPresenter
]

{ #category : '*Spec2-ListView' }
SpTPresenterBuilder >> newEasyListView [

	^ self instantiate: SpEasyListViewPresenter
]

{ #category : '*Spec2-ListView' }
SpTPresenterBuilder >> newListView [

	^ self instantiate: SpListViewPresenter
]
