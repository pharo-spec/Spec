Extension { #name : #SpPresenter }

{ #category : #'*Spec2-MorphicPresenters' }
SpPresenter >> newImage [
	^ self instantiate: SpImagePresenter
]

{ #category : #'*Spec2-MorphicPresenters' }
SpPresenter >> newLink [
	^ self instantiate: SpLinkPresenter
]

{ #category : #'*Spec2-MorphicPresenters' }
SpPresenter >> newMorph [

	^ self instantiate: SpMorphPresenter
]
