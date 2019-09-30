Class {
	#name : #SpTreeMultipleSelectionMode,
	#superclass : #SpAbstractTreeSingleSelectionMode,
	#category : #'Spec2-Core-Widgets-Tree'
}

{ #category : #testing }
SpTreeMultipleSelectionMode >> includesItem: anItem [
	^ self selectedItems includes: anItem
]

{ #category : #testing }
SpTreeMultipleSelectionMode >> includesItems: anItemList [
	^ self selectedItems includesAll: anItemList
]

{ #category : #testing }
SpTreeMultipleSelectionMode >> includesPath: aPath [
	^ selection includes: aPath
]

{ #category : #testing }
SpTreeMultipleSelectionMode >> includesPaths: aListOfPaths [
	^ selection includesAll: aListOfPaths
]

{ #category : #testing }
SpTreeMultipleSelectionMode >> isMultipleSelection [

	^ true
]

{ #category : #selection }
SpTreeMultipleSelectionMode >> pathOf: anItem [
	^ SpTreeBreadthFirstSearch new
		tree: presenter;
		search: anItem
]

{ #category : #selection }
SpTreeMultipleSelectionMode >> selectItem: anItem [
	[ self selectPath: (self pathOf: anItem) ]
		on: NotFound
		do: [ "ignore. we do not change the selection" ]
]

{ #category : #selection }
SpTreeMultipleSelectionMode >> selectItems: aListOfItems [
	aListOfItems do: 
		[ :each |
			[ self selectPath: (self pathOf: each) ]
			on: NotFound
			do: [ "ignore. we do not change the selection" ] ]
]

{ #category : #selection }
SpTreeMultipleSelectionMode >> selectPath: aPath [ 
	"Check comment in my superclass to know how to use selectPath:"
	
	(selection includes: aPath) ifTrue: [ ^ self ].
	presenter itemAtPath: aPath ifAbsent: [ ^ self ].
	
	selection := selection copyWith: aPath.
]

{ #category : #selection }
SpTreeMultipleSelectionMode >> selectPaths: pathArray [
	pathArray
		do: [ :path | presenter itemAtPath: path ifAbsent: [ ^ self ] ].
	selection = pathArray ifTrue: [ ^ self ].
	
	selection := pathArray
]

{ #category : #accessing }
SpTreeMultipleSelectionMode >> selectedItem [
	self shouldNotImplement.
]

{ #category : #accessing }
SpTreeMultipleSelectionMode >> selectedItems [
	selection ifEmpty: [ ^ #() ].
	^ selection collect: [ :path | presenter itemAtPath: path ]
]

{ #category : #accessing }
SpTreeMultipleSelectionMode >> selectedPaths [
	^ selection
]

{ #category : #selection }
SpTreeMultipleSelectionMode >> unselectItem: anItem [
	[ self unselectPath: (self pathOf: anItem) ]
	on: NotFound 
	do: [ "ignore. nothing to unselect" ]
]

{ #category : #selection }
SpTreeMultipleSelectionMode >> unselectPath: aPath [
	self selectPaths: (self selectedPaths copyWithout: aPath)
]
