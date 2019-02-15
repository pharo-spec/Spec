Extension { #name : #FTSelectionChanged }

{ #category : #'*Spec-Pharo7To8Compatibility' }
FTSelectionChanged >> newSelectedIndexes [
	
	^ self newSelectedRowIndexes 
]

{ #category : #'*Spec-Pharo7To8Compatibility' }
FTSelectionChanged >> oldSelectedIndexes [

	^ self oldSelectedRowIndexes 
]
