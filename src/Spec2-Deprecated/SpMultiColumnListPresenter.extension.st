Extension { #name : #SpMultiColumnListPresenter }

{ #category : #'*Spec2-Deprecated' }
SpMultiColumnListPresenter class >> isDeprecated [
	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpMultiColumnListPresenter >> items: items [
	
	items ifNotEmpty: [ self numberOfColumns: (displayBlock value: items first) size ].
	super items: items
]
