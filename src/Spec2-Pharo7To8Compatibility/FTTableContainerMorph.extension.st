Extension { #name : #FTTableContainerMorph }

{ #category : #'*Spec2-Pharo7To8Compatibility' }
FTTableContainerMorph >> firstVisibleRowIndex [

	^ self exposedRows
		ifNotEmpty: [ :rows | rows keys first ]
		ifEmpty: [ 0 ]
]

{ #category : #'*Spec2-Pharo7To8Compatibility' }
FTTableContainerMorph >> headerRow [
	^ headerRow
]

{ #category : #'*Spec2-Pharo7To8Compatibility' }
FTTableContainerMorph >> lastVisibleRowIndex [

	^ self exposedRows
		ifNotEmpty: [ :rows | rows keys last ]
		ifEmpty: [ 0 ]
]
