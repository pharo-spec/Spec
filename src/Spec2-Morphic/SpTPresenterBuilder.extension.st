Extension { #name : 'SpTPresenterBuilder' }

{ #category : '*Spec2-Morphic' }
SpTPresenterBuilder >> newLink [
	^ self instantiate: SpLinkPresenter
]

{ #category : '*Spec2-Morphic' }
SpTPresenterBuilder >> newMorph [

	^ self instantiate: SpMorphPresenter
]
