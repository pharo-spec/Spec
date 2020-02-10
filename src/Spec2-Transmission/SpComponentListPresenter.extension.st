Extension { #name : #SpComponentListPresenter }

{ #category : #'*Spec2-Transmission' }
SpComponentListPresenter >> defaultInputPort [

	^ self inputItemsPort
]

{ #category : #'*Spec2-Transmission' }
SpComponentListPresenter >> defaultOutputPort [

	^ self outputSelectionPort
]

{ #category : #'*Spec2-Transmission' }
SpComponentListPresenter >> inputItemsPort [

	^ SpListItemsPort newPresenter: self
]

{ #category : #'*Spec2-Transmission' }
SpComponentListPresenter >> outputActivationPort [
	
	^ SpActivationPort newPresenter: self
]

{ #category : #'*Spec2-Transmission' }
SpComponentListPresenter >> outputSelectionPort [
	
	^ SpSelectionPort newPresenter: self
]
