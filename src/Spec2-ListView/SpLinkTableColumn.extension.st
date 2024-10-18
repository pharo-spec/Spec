Extension { #name : 'SpLinkTableColumn' }

{ #category : '*Spec2-ListView' }
SpLinkTableColumn >> fillPresenter: aPresenter with: item [
		
	item ifNil: [ 
		aPresenter label: ''.
		^ self ].
	
	aPresenter 
		label: (self readObject: item) asString;
		action: self action
]
