Extension { #name : #FTBasicItem }

{ #category : #'*Spec2-Adapters-Morphic' }
FTBasicItem >> expandedChildren [
	self isExpanded ifFalse: [ ^ { self } ].
	^ {self} , (self children flatCollect: [ :e | e expandedChildren ])
]

{ #category : #'*Spec2-Adapters-Morphic' }
FTBasicItem >> withExpandedChildren [
	^ self expandedChildren
]
