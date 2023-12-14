Extension { #name : 'FTBasicItem' }

{ #category : '*Spec2-Pharo7To8Compatibility' }
FTBasicItem >> expandedChildren [
	self isExpanded ifFalse: [ ^ { self } ].
	^ {self} , (self children flatCollect: [ :e | e expandedChildren ])
]

{ #category : '*Spec2-Pharo7To8Compatibility' }
FTBasicItem >> withExpandedChildren [
	^ self expandedChildren
]
