Extension { #name : 'SpTPresenterBuilder' }

{ #category : '*Spec2-ListView' }
SpTPresenterBuilder >> newColumnView [

	^ self instantiate: SpColumnViewPresenter
]

{ #category : '*Spec2-ListView' }
SpTPresenterBuilder >> newDropDown [

	^ self instantiate: SpDropDownPresenter
]

{ #category : '*Spec2-ListView' }
SpTPresenterBuilder >> newEasyColumnView [

	^ self instantiate: SpEasyColumnViewPresenter
]

{ #category : '*Spec2-ListView' }
SpTPresenterBuilder >> newEasyListView [

	^ self instantiate: SpEasyListViewPresenter
]

{ #category : '*Spec2-ListView' }
SpTPresenterBuilder >> newEasyTreeColumnView [

	^ self instantiate: SpEasyTreeColumnViewPresenter
]

{ #category : '*Spec2-ListView' }
SpTPresenterBuilder >> newEasyTreeListView [

	^ self instantiate: SpEasyTreeListViewPresenter
]

{ #category : '*Spec2-ListView' }
SpTPresenterBuilder >> newListView [

	^ self instantiate: SpListViewPresenter
]

{ #category : '*Spec2-ListView' }
SpTPresenterBuilder >> newTreeColumnView [

	^ self instantiate: SpTreeColumnViewPresenter
]

{ #category : '*Spec2-ListView' }
SpTPresenterBuilder >> newTreeListView [

	^ self instantiate: SpTreeListViewPresenter
]
