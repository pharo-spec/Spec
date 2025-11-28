Extension { #name : 'SpImagePresenter' }

{ #category : '*Spec2-Transmission' }
SpImagePresenter >> defaultInputPort [

	^ self inputImagePort
]

{ #category : '*Spec2-Transmission' }
SpImagePresenter >> inputImagePort [

	^ SpImagePort newPresenter: self
]
