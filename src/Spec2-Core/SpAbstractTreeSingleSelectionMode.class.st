Class {
	#name : #SpAbstractTreeSingleSelectionMode,
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
SpAbstractTreeSingleSelectionMode class >> on: aPresenter [

	^ self new
		presenter: aPresenter;
		yourself
]

{ #category : #selection }
SpAbstractTreeSingleSelectionMode >> clearSelection [

	selection := #()
]

{ #category : #initialization }
SpAbstractTreeSingleSelectionMode >> initialize [
	self class initializeSlots: self.
	selection := #().
	super initialize.

]

{ #category : #testing }
SpAbstractTreeSingleSelectionMode >> isEmpty [
	
	^ selection isEmpty
]

{ #category : #accessing }
SpAbstractTreeSingleSelectionMode >> isMultipleSelection [
	^ false
]

{ #category : #accesing }
SpAbstractTreeSingleSelectionMode >> presenter: aPresenter [
	presenter := aPresenter
]

{ #category : #selection }
SpAbstractTreeSingleSelectionMode >> selectItem: anItem [ 
	self subclassResponsibility
]

{ #category : #selection }
SpAbstractTreeSingleSelectionMode >> selectItems: aListOfItems [
	self subclassResponsibility
]

{ #category : #selection }
SpAbstractTreeSingleSelectionMode >> selectPath: aPath [
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
SpAbstractTreeSingleSelectionMode >> selectPaths: pathArray [
	self subclassResponsibility
]

{ #category : #accessing }
SpAbstractTreeSingleSelectionMode >> selectedItem [
	^ self subclassResponsibility
]

{ #category : #accessing }
SpAbstractTreeSingleSelectionMode >> selectedPaths [
	^ self subclassResponsibility
]

{ #category : #selecting }
SpAbstractTreeSingleSelectionMode >> unselectAll [

	self clearSelection
]

{ #category : #selecting }
SpAbstractTreeSingleSelectionMode >> unselectItem: anItem [
	self subclassResponsibility
]

{ #category : #selecting }
SpAbstractTreeSingleSelectionMode >> unselectPath: aPath [
	self subclassResponsibility
]

{ #category : #'api - events' }
SpAbstractTreeSingleSelectionMode >> whenChangedDo: aBlockClosure [ 
	
	self property: #selection whenChangedDo: aBlockClosure 
]
