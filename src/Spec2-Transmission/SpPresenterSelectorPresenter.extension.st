Extension { #name : 'SpPresenterSelectorPresenter' }

{ #category : '*Spec2-Transmission' }
SpPresenterSelectorPresenter >> defaultInputPort [

	^ self inputModelPort
]

{ #category : '*Spec2-Transmission' }
SpPresenterSelectorPresenter >> inputModelPort [

	^ SpModelPort newPresenter: self
]
