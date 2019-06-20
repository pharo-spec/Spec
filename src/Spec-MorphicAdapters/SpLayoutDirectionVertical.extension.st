Extension { #name : #SpLayoutDirectionVertical }

{ #category : #'*Spec-MorphicAdapters' }
SpLayoutDirectionVertical >> setRigidityOfNonExpendedMorph: aMorph [ 
	aMorph 
		hResizing: #spaceFill; 
		vResizing: #rigid
]
