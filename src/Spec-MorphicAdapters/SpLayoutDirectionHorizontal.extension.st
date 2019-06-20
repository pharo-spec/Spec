Extension { #name : #SpLayoutDirectionHorizontal }

{ #category : #'*Spec-MorphicAdapters' }
SpLayoutDirectionHorizontal >> setRigidityOfNonExpendedMorph: aMorph [ 
	aMorph 
		vResizing: #spaceFill; 
		hResizing: #rigid
]
