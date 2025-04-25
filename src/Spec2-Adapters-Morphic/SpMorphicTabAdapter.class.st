Class {
	#name : 'SpMorphicTabAdapter',
	#superclass : 'SpMorphicLayoutAdapter',
	#instVars : [
		'lastPage'
	],
	#category : 'Spec2-Adapters-Morphic-Layout',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Layout'
}

{ #category : 'private' }
SpMorphicTabAdapter >> addConstraints: constraints toChild: childMorph [
	"Adds constraits by child"
	| theMorph |	
	
	theMorph := childMorph.
	"Keep constraints to layout usage"
	theMorph setProperty: #constraints toValue: constraints. 
	
	^ theMorph 
]

{ #category : 'private' }
SpMorphicTabAdapter >> basicAdd: aPresenter constraints: constraints to: aNotebook [ 
	| page |

	page := SpNotebookPageMorph new 
		lazyPageMorphCreation: [ self buildMorph: aPresenter constraints: constraints ];
		yourself.
	
	aNotebook addPage: page label: constraints label
]

{ #category : 'accessing' }
SpMorphicTabAdapter >> children [

	^ widget pages
]

{ #category : 'protocol' }
SpMorphicTabAdapter >> layout: aLayout [

	layout := aLayout.

	widget ifNil: [
		widget := self newNotebookMorph ].

	aLayout whenChildrenAddedDo: [ :ann |
		self
			basicAdd: ann child
			constraints: (aLayout constraintsFor: ann child)
			to: widget ].

	aLayout whenChildrenRemovedDo: [ :ann | self remove: ann child ].

	self presenter whenDisplayDo: [
		widget pages ifNotEmpty: [ widget selectedPageIndex: 1 ] ].

	super layout: aLayout
]

{ #category : 'private' }
SpMorphicTabAdapter >> newNotebookMorph [
	| notebookMorph |

	notebookMorph := SpNotebookMorph new
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		yourself.
		
	notebookMorph announcer 
		when: SpNotebookPageChanged
		send: #pageChanged: 
		to: self.
	
	^ notebookMorph
]

{ #category : 'private' }
SpMorphicTabAdapter >> pageChanged: ann [
	lastPage ifNotNil: [
		layout announce: (SpTabUnselected newPresenter: lastPage) ].
	lastPage := layout children at: ann pageIndex.
	layout announce: (SpTabSelected newPresenter: lastPage)
]

{ #category : 'removing' }
SpMorphicTabAdapter >> remove: aPresenter [

	aPresenter adapter ifNotNil: [ :adapter |
		| morph |
		morph := adapter widget.
		widget removePage: (widget pages detect: [ :each | each actualPageMorph = morph ]) ]
]

{ #category : 'accessing' }
SpMorphicTabAdapter >> selectIndex: aNumber [
	
	self widget selectedPageIndex: aNumber
]
