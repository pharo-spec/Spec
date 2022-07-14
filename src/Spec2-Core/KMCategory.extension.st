Extension { #name : #KMCategory }

{ #category : #'*Spec2-Core' }
KMCategory >> , aKMCategory [ 
	| newCategory |
	
	newCategory := self class new.
	self keymaps do: [ :each | newCategory addKeymapEntry: each ].
	aKMCategory keymaps do: [ :each | newCategory addKeymapEntry: each ].
	^ newCategory
]
