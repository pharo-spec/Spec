Extension { #name : 'PRHeader' }

{ #category : '*Spec2-Pillar' }
PRHeader >> plaintextAppendix [ 
	^ self plaintextNewline 
]

{ #category : '*Spec2-Pillar' }
PRHeader >> styleName [
	^  #header, level asString 
]
