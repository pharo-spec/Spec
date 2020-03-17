Extension { #name : #SpTabPresenterTest }

{ #category : #'*Spec2-Deprecated' }
SpTabPresenterTest >> classToTest [
	^ SpTabPresenter
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenterTest >> initializeTestedInstance [
	manager := SpTabManagerPresenter new
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenterTest class >> isDeprecated [
	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenterTest >> redMorphTab [
	presenter
		label: 'Red Morph';
		icon: (presenter iconNamed: #smallBackIcon);
		contents:
			(Morph new
				color: Color red;
				yourself).
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenterTest >> testChangeLabel [
	"issue 14885"

	self redMorphTab.
	manager addTab: presenter.
	self assert: presenter label equals: 'Red Morph'.
	presenter label: 'Change Before Opening'.
	self assert: presenter label equals: 'Change Before Opening'.
	window := manager openWithSpec.
	presenter label: 'Change After Opening'.
	self assert: presenter label equals: 'Change After Opening'
]

{ #category : #'*Spec2-Deprecated' }
SpTabPresenterTest >> testSetOwner [
	"issue 16553"

	| button |
	button := SpButtonPresenter new.
	self assert: button owner isNil.
	
	presenter presenter: button.
	self assert: button owner equals: presenter
]
