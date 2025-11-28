Class {
	#name : 'SpTreeMultipleSelectionMode',
	#superclass : 'SpAbstractTreeSelectionMode',
	#category : 'Spec2-Core-Widgets-Tree',
	#package : 'Spec2-Core',
	#tag : 'Widgets-Tree'
}

{ #category : 'adding' }
SpTreeMultipleSelectionMode >> addAllPathsOf: items parentPath: aCollection to: allPaths [

	items withIndexDo: [ :item :index |
			| itemPath |
			itemPath := aCollection , { index }.
			allPaths add: itemPath.
			(presenter childrenFor: item) ifNotEmpty: [ :childrens |
				self addAllPathsOf: childrens parentPath: itemPath to: allPaths ] ]
]

{ #category : 'testing' }
SpTreeMultipleSelectionMode >> includesItem: anItem [
	^ self selectedItems includes: anItem
]

{ #category : 'testing' }
SpTreeMultipleSelectionMode >> includesItems: anItemList [
	^ self selectedItems includesAll: anItemList
]

{ #category : 'testing' }
SpTreeMultipleSelectionMode >> includesPath: aPath [
	^ selection includes: aPath
]

{ #category : 'testing' }
SpTreeMultipleSelectionMode >> includesPaths: aListOfPaths [
	^ selection includesAll: aListOfPaths
]

{ #category : 'testing' }
SpTreeMultipleSelectionMode >> isMultipleSelection [

	^ true
]

{ #category : 'selecting' }
SpTreeMultipleSelectionMode >> selectAll [

	| paths |
	paths := OrderedCollection new.
	self addAllPathsOf: presenter roots parentPath: #(  ) to: paths.
	self selectPaths: paths
]

{ #category : 'selection' }
SpTreeMultipleSelectionMode >> selectPath: aPath [ 
	"Check comment in my superclass to know how to use selectPath:"
	
	aPath ifEmpty: [ ^ self unselectAll ].
	(selection includes: aPath) ifTrue: [ ^ self ].
	presenter itemAtPath: aPath ifAbsent: [ ^ self ].
	
	selection := selection copyWith: aPath.
]

{ #category : 'selection' }
SpTreeMultipleSelectionMode >> selectPaths: pathArray [

	| paths |
	paths := pathArray asArray.
	(paths isEmpty or: [ paths size = 1 and: [ paths first isEmpty ] ]) ifTrue: [ ^ self unselectAll ].

	paths do: [ :path | presenter itemAtPath: path ifAbsent: [ ^ self ] ].
	selection = paths ifTrue: [ ^ self ].

	selection := paths
]

{ #category : 'accessing' }
SpTreeMultipleSelectionMode >> selectedItem [

	^ self selectedPaths 
		ifNotEmpty: [ :paths | presenter itemAtPath: paths first  ]
		ifEmpty: [ nil ]
]

{ #category : 'accessing' }
SpTreeMultipleSelectionMode >> selectedItems [
	selection ifEmpty: [ ^ #() ].
	^ selection collect: [ :path | presenter itemAtPath: path ]
]

{ #category : 'accessing' }
SpTreeMultipleSelectionMode >> selectedPath [
	
	^ self selectedPaths 
		ifNotEmpty: [ :paths | paths last ]
		ifEmpty: [ nil ]
]

{ #category : 'accessing' }
SpTreeMultipleSelectionMode >> selectedPaths [
	^ selection
]

{ #category : 'selection' }
SpTreeMultipleSelectionMode >> unselectPath: aPath [
	self selectPaths: (self selectedPaths copyWithout: aPath)
]
