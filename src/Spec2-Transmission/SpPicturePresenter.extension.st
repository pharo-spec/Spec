Extension { #name : 'SpPicturePresenter' }

{ #category : '*Spec2-Transmission' }
SpPicturePresenter >> defaultInputPort [

	^ self inputImagePort
]

{ #category : '*Spec2-Transmission' }
SpPicturePresenter >> inputImagePort [

	^ SpImagePort newPresenter: self
]
