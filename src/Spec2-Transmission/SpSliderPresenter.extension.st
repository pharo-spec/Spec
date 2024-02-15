Extension { #name : 'SpSliderPresenter' }

{ #category : '*Spec2-Transmission' }
SpSliderPresenter >> absoluteValueOutputPort [

	^ SpPropertyChangedPort
		newPresenter: self
		property: #absoluteValue
]
