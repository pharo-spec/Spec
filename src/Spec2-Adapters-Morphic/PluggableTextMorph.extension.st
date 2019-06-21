Extension { #name : #PluggableTextMorph }

{ #category : #'*Spec2-Adapters-Morphic' }
PluggableTextMorph >> registerScrollChanges: aSelector [

	self announcer 
		when: PaneScrolling 
		send: aSelector
		to: self model
]
