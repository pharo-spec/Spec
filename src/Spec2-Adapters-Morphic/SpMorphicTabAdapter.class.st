Class {
	#name : #SpMorphicTabAdapter,
	#superclass : #SpMorphicLayoutAdapter,
	#category : #'Spec2-Adapters-Morphic-Layout'
}

{ #category : #private }
SpMorphicTabAdapter >> addConstraints: constraints toChild: childMorph [
	"Adds constraits by child"
	| theMorph |	
	
	theMorph := childMorph.
	"Keep constraints to layout usage"
	theMorph setProperty: #constraints toValue: constraints. 
	
	^ theMorph 
]

{ #category : #private }
SpMorphicTabAdapter >> basicAdd: aPresenter constraints: constraints to: aNotebook [ 
	| page |

	page := SpNotebookPageMorph new 
		lazyPageMorphCreation: [ self buildMorph: aPresenter constraints: constraints ];
		yourself.
	
	aNotebook addPage: page label: constraints label
]

{ #category : #accessing }
SpMorphicTabAdapter >> children [

	^ widget pages
]

{ #category : #protocol }
SpMorphicTabAdapter >> layout: aLayout [

	layout := aLayout.

	widget ifNil: [
		widget := SpNotebookMorph new
			vResizing: #spaceFill;
			hResizing: #spaceFill;
			yourself ].

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

{ #category : #removing }
SpMorphicTabAdapter >> remove: aPresenter [

	widget removePage: (widget pages 
		detect: [ :each | each actualPageMorph = aPresenter adapter widget ])
]
