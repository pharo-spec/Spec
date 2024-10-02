Extension { #name : 'CmUIDisplayAsGroup' }

{ #category : '*Spec2-Commander2' }
CmUIDisplayAsGroup >> display: aCmSpecCommandGroup in: aMenuPresenter do: aBlock [
		
	aMenuPresenter addGroup: [ :menuGroup |
		aBlock value: menuGroup ]
]

{ #category : '*Spec2-Commander2' }
CmUIDisplayAsGroup >> isGroup [

	^ true
]
