Extension { #name : #SpWindowPresenter }

{ #category : #'*Spec-Deprecated80' }
SpWindowPresenter >> model [
	self deprecated: 'Model was renamed Presenter in Pharo 7' transformWith: '`@receiver model' -> '`@receiver presenter'.
	
	^ self presenter
]

{ #category : #'*Spec-Deprecated80' }
SpWindowPresenter >> model: aModel [
	self deprecated: 'Model was renamed Presenter in Pharo 7' transformWith: '`@receiver model: `@statements1' -> '`@receiver presenter: `@statements1'.

	self presenter: aModel
]
