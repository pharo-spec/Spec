Extension { #name : #FTBasicItem }

{ #category : #'*Spec2-Adapters-Morphic' }
FTBasicItem >> spWithExpandedChildren [
	self isExpanded ifFalse: [ ^ {self} ].
	^ {self} , (self children flatCollect: [ :e | e spWithExpandedChildren ])
]
