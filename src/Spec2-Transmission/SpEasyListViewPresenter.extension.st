Extension { #name : #SpEasyListViewPresenter }

{ #category : #'*Spec2-Transmission' }
SpEasyListViewPresenter >> defaultInputPort [

	^ self inputItemsPort
]

{ #category : #'*Spec2-Transmission' }
SpEasyListViewPresenter >> defaultOutputPort [

	^ self outputSelectionPort
]

{ #category : #'*Spec2-Transmission' }
SpEasyListViewPresenter >> inputItemsPort [

	^ (SpListItemsPort newPresenter: self)
		delegateTo: [ listView ];
		yourself	
]

{ #category : #'*Spec2-Transmission' }
SpEasyListViewPresenter >> outputActivationPort [
	
	^ (SpActivationPort newPresenter: self)
		delegateTo: [ listView ];
		yourself
]

{ #category : #'*Spec2-Transmission' }
SpEasyListViewPresenter >> outputSelectionPort [
	
	^ (SpSelectionPort newPresenter: self)
		delegateTo: [ listView ];
		yourself
]
