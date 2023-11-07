Extension { #name : 'SpDropDownPresenter' }

{ #category : '*Spec2-Transmission' }
SpDropDownPresenter >> defaultInputPort [

	^ self inputItemsPort
]

{ #category : '*Spec2-Transmission' }
SpDropDownPresenter >> defaultOutputPort [

	^ self outputSelectionPort
]

{ #category : '*Spec2-Transmission' }
SpDropDownPresenter >> inputItemsPort [

	^ SpListItemsPort newPresenter: self
]

{ #category : '*Spec2-Transmission' }
SpDropDownPresenter >> outputSelectionPort [

	^ SpDropDownSelectionPort newPresenter: self
]
