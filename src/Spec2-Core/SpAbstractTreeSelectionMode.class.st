Class {
	#name : #SpAbstractTreeSelectionMode,
	#superclass : #Object,
	#traits : 'TSpObservable',
	#classTraits : 'TSpObservable classTrait',
	#instVars : [
		'#selection => SpObservableSlot',
		'#presenter'
	],
	#category : #'Spec2-Core-Widgets-Tree'
}

{ #category : #'accessing method dictionary' }
SpAbstractTreeSelectionMode class >> on: aPresenter [

	^ self new
		presenter: aPresenter;
		yourself
]

{ #category : #selection }
SpAbstractTreeSelectionMode >> clearSelection [

	selection := #()
]

{ #category : #initialization }
SpAbstractTreeSelectionMode >> initialize [
	self class initializeSlots: self.
	selection := #().
	super initialize.

]

{ #category : #testing }
SpAbstractTreeSelectionMode >> isEmpty [
	
	^ selection isEmpty
]

{ #category : #accessing }
SpAbstractTreeSelectionMode >> isMultipleSelection [
	^ false
]

{ #category : #selection }
SpAbstractTreeSelectionMode >> itemNotFoundAction [
	"ignore. we do not change the selection"
]

{ #category : #selection }
SpAbstractTreeSelectionMode >> pathOf: anItem [
	^ SpTreeBreadthFirstSearch new
		tree: presenter;
		search: anItem
]

{ #category : #accesing }
SpAbstractTreeSelectionMode >> presenter: aPresenter [
	presenter := aPresenter
]

{ #category : #selection }
SpAbstractTreeSelectionMode >> selectItem: anItem [
	[ self selectPath: (self pathOf: anItem) ]
		on: NotFound
		do: [ self itemNotFoundAction ]
]

{ #category : #selection }
SpAbstractTreeSelectionMode >> selectItems: aListOfItems [
	aListOfItems do: 
		[ :each |
			[ self selectPath: (self pathOf: each) ]
			on: NotFound
			do: [ "ignore. we do not change the selection" ] ]
]

{ #category : #selection }
SpAbstractTreeSelectionMode >> selectPath: aPath [
	"Select a node in the tree by providing a list of indexes.
	Example:
		A
			B
			C
			E
		D
			G
			T
	selectPath( #(1 2) ) will select the node C
	selectPath( #(2 1) ) will select the node G
	selectPath( #(2) ) will select the node D
	"
	
	self subclassResponsibility
]

{ #category : #selection }
SpAbstractTreeSelectionMode >> selectPaths: pathArray [
	self subclassResponsibility
]

{ #category : #accessing }
SpAbstractTreeSelectionMode >> selectedItem [
	^ self subclassResponsibility
]

{ #category : #accessing }
SpAbstractTreeSelectionMode >> selectedPaths [
	^ self subclassResponsibility
]

{ #category : #selecting }
SpAbstractTreeSelectionMode >> unselectAll [

	self clearSelection
]

{ #category : #selection }
SpAbstractTreeSelectionMode >> unselectItem: anItem [
	[ self unselectPath: (self pathOf: anItem) ]
	on: NotFound 
	do: [ "ignore. nothing to unselect" ]
]

{ #category : #selecting }
SpAbstractTreeSelectionMode >> unselectPath: aPath [
	self subclassResponsibility
]

{ #category : #'api - events' }
SpAbstractTreeSelectionMode >> whenChangedDo: aBlockClosure [ 
	
	self property: #selection whenChangedDo: aBlockClosure 
]
