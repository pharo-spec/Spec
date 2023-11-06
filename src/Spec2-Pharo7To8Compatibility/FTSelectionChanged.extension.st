Extension { #name : 'FTSelectionChanged' }

{ #category : '*Spec2-Pharo7To8Compatibility' }
FTSelectionChanged >> newSelectedIndexes [
	
	^ self newSelectedRowIndexes 
]

{ #category : '*Spec2-Pharo7To8Compatibility' }
FTSelectionChanged >> oldSelectedIndexes [

	^ self oldSelectedRowIndexes 
]
