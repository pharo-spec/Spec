Extension { #name : 'SpTModel' }

{ #category : '*Spec2-Transmission' }
SpTModel >> defaultInputPort [

	^ self inputModelPort
]

{ #category : '*Spec2-Transmission' }
SpTModel >> inputModelPort [

	^ SpModelPort newPresenter: self
]
