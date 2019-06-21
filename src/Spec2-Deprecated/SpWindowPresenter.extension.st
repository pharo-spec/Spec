Extension { #name : #SpWindowPresenter }

{ #category : #'*Spec2-Deprecated' }
SpWindowPresenter >> model [
	self deprecated: 'Model was renamed Presenter in Pharo 7' transformWith: '`@receiver model' -> '`@receiver presenter'.
	
	^ self presenter
]

{ #category : #'*Spec2-Deprecated' }
SpWindowPresenter >> model: aModel [
	self deprecated: 'Model was renamed Presenter in Pharo 7' transformWith: '`@receiver model: `@statements1' -> '`@receiver presenter: `@statements1'.

	self presenter: aModel
]
