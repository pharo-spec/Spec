Extension { #name : #MorphTreeNodeMorph }

{ #category : #'*Spec2-Adapters-Morphic' }
MorphTreeNodeMorph >> isMorphicModel [

	^ true
]

{ #category : #'*Spec2-Adapters-Morphic' }
MorphTreeNodeMorph >> model [

	^ self complexContents
]
