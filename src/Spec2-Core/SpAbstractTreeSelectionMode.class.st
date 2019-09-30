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

{ #category : #accesing }
SpAbstractTreeSelectionMode >> presenter: aPresenter [
	presenter := aPresenter
]

{ #category : #selection }
SpAbstractTreeSelectionMode >> selectItem: anItem [ 
	self subclassResponsibility
]

{ #category : #selection }
SpAbstractTreeSelectionMode >> selectItems: aListOfItems [
	self subclassResponsibility
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

{ #category : #selecting }
SpAbstractTreeSelectionMode >> unselectItem: anItem [
	self subclassResponsibility
]

{ #category : #selecting }
SpAbstractTreeSelectionMode >> unselectPath: aPath [
	self subclassResponsibility
]

{ #category : #'api - events' }
SpAbstractTreeSelectionMode >> whenChangedDo: aBlockClosure [ 
	
	self property: #selection whenChangedDo: aBlockClosure 
]
