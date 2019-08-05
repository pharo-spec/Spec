Extension { #name : #SpToolBarPresenterTest }

{ #category : #'*Spec2-PolyWidgets-Tests' }
SpToolBarPresenterTest >> testAddItemPosition [
	| itemLeft itemRight |

	self assert: presenter items isEmpty.
	presenter addItem: (itemLeft := self newToolbarItem) position: SpToolBarItemPosition left.
	presenter addItem: (itemRight := self newToolbarItem) position: SpToolBarItemPosition right.

	self assertCollection: presenter leftItems hasSameElements: { itemLeft }.
	self assertCollection: presenter rightItems hasSameElements: { itemRight }.

]

{ #category : #'*Spec2-PolyWidgets-Tests' }
SpToolBarPresenterTest >> testItems [ 
	| item |

	self assert: presenter items isEmpty.
	presenter addItem: (item := self newToolbarItem).

	self assertCollection: presenter leftItems hasSameElements: { item }.

]
