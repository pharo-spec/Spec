Extension { #name : #FTTableMorph }

{ #category : #'*Spec-Pharo7To8Compatibility' }
FTTableMorph >> basicSelectIndexes: aCollection [ 
	
	^ self basicSelectRowIndexes: aCollection
]

{ #category : #'*Spec-Pharo7To8Compatibility' }
FTTableMorph >> selectedIndexes [
	
	^ self selectedRowIndexes
]
