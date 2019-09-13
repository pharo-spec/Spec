Extension { #name : #FTTableMorph }

{ #category : #'*Spec2-Pharo7To8Compatibility' }
FTTableMorph >> basicSelectIndexes: aCollection [ 
	
	^ self basicSelectRowIndexes: aCollection
]

{ #category : #'*Spec2-Pharo7To8Compatibility' }
FTTableMorph >> firstVisibleRowIndex [
	^ self container firstVisibleRowIndex
]

{ #category : #'*Spec2-Pharo7To8Compatibility' }
FTTableMorph >> lastVisibleRowIndex [

	^ self container lastVisibleRowIndex
]

{ #category : #'*Spec2-Pharo7To8Compatibility' }
FTTableMorph >> scrollToIndex: index [
	self inform: 'Unimplemented feature. This feature is only available in Pharo 8.'
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
