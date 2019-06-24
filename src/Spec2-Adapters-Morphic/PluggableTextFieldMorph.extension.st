Extension { #name : #PluggableTextFieldMorph }

{ #category : #'*Spec2-Adapters-Morphic' }
PluggableTextFieldMorph >> setTextAndAccept: aText [
	self
		setText: aText;
		hasUnacceptedEdits: true;
		accept
]
