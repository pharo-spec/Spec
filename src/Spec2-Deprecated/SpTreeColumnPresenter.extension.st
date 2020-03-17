Extension { #name : #SpTreeColumnPresenter }

{ #category : #'*Spec2-Deprecated' }
SpTreeColumnPresenter class >> adapterName [

	^ #TreeColumnAdapter
]

{ #category : #'*Spec2-Deprecated' }
SpTreeColumnPresenter >> container [

	^ container value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeColumnPresenter >> container: aTreePresenter [

	container value: aTreePresenter
]

{ #category : #'*Spec2-Deprecated' }
SpTreeColumnPresenter >> displayBlock [

	^ displayBlock value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeColumnPresenter >> displayBlock: aBlock [

	displayBlock value: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpTreeColumnPresenter >> headerAction [

	^ headerAction value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeColumnPresenter >> headerAction: aBlock [

	headerAction value: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpTreeColumnPresenter >> headerFont [

	^ headerFont value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeColumnPresenter >> headerFont: aFont [

	headerFont value: aFont
]

{ #category : #'*Spec2-Deprecated' }
SpTreeColumnPresenter >> headerIcon [

	^ headerIcon value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeColumnPresenter >> headerIcon: anIcon [

	headerIcon value: anIcon
]

{ #category : #'*Spec2-Deprecated' }
SpTreeColumnPresenter >> headerLabel [

	^ headerLabel value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeColumnPresenter >> headerLabel: aString [

	headerLabel value: aString
]

{ #category : #'*Spec2-Deprecated' }
SpTreeColumnPresenter >> initialWidth [

	^ initialWidth value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeColumnPresenter >> initialWidth: anInteger [

	initialWidth value: anInteger
]

{ #category : #'*Spec2-Deprecated' }
SpTreeColumnPresenter >> initialize [

	super initialize.

	container := nil asValueHolder.
	displayBlock := [ :node | node printString ] asValueHolder.
	initialWidth := 100 asValueHolder.
	resizable := true asValueHolder.
	headerLabel := nil asValueHolder.
	headerFont := self class defaultFont asValueHolder.
	headerIcon := nil asValueHolder.
	headerAction := nil asValueHolder.
	
	self registerEvents
]

{ #category : #'*Spec2-Deprecated' }
SpTreeColumnPresenter class >> isDeprecated [ 

	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpTreeColumnPresenter >> registerEvents [

	displayBlock whenChangedDo: [ self changed: #displayBlockChanged ].
	resizable whenChangedDo: [ self changed: #resizableChanged ].
	headerLabel whenChangedDo: [ self changed: #headerLabelChanged ].
	headerFont whenChangedDo: [ self changed: #headerFontChanged ].
	headerIcon whenChangedDo: [ self changed: #headerIconChanged ]
]

{ #category : #'*Spec2-Deprecated' }
SpTreeColumnPresenter >> resizable [

	^ resizable value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeColumnPresenter >> resizable: aBoolean [

	resizable value: aBoolean
]
