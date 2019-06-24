Extension { #name : #FTTableMorph }

{ #category : #'*Spec2-Pharo7To8Compatibility' }
FTTableMorph >> basicSelectIndexes: aCollection [ 
	
	^ self basicSelectRowIndexes: aCollection
]

{ #category : #'*Spec2-Pharo7To8Compatibility' }
FTTableMorph >> selectIndex: anInteger [ 
	
	self selectRowIndex: anInteger
]

{ #category : #'*Spec2-Pharo7To8Compatibility' }
FTTableMorph >> selectIndexes: indexes [
	
	self selectRowIndexes: indexes
]

{ #category : #'*Spec2-Pharo7To8Compatibility' }
FTTableMorph >> selectedIndex [
	
	^ self selectedRowIndex
]

{ #category : #'*Spec2-Pharo7To8Compatibility' }
FTTableMorph >> selectedIndexes [
	
	^ self selectedRowIndexes
]
