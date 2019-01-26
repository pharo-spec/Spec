"
I'm an adapter to show a notebook (a tab manager)
"
Class {
	#name : #MorphicNotebookAdapter,
	#superclass : #AbstractMorphicAdapter,
	#category : #'Spec-MorphicAdapters-Base'
}

{ #category : #factory }
MorphicNotebookAdapter >> addModelTo: aNotebook [
	
	self model pages ifEmpty: [ ^ self ].
	self model pages do: [ :each |
		aNotebook 
			addLazyPage: [ each retrievePresenter buildWithSpec ] 
			label: (self buildLabelForPage: each).
		"Since I do not have the page added, I need to take it from the list. 
		 But I know this will be the last added :)"
		aNotebook pages last model: each ].
	"force first page to be drawn"
	aNotebook selectedPageIndex: 1
]

{ #category : #factory }
MorphicNotebookAdapter >> buildLabelForPage: aPage [
	"I cannot use a PanelMorph here (as I would like) because Panels have bg colors setted 
	 from theme (and then... they look always same in the tab)"
	
	^ Morph new 
		changeTableLayout;
		vResizing: #spaceFill;
		hResizing: #shrinkWrap;
		color: Color transparent;
		listDirection: #leftToRight;
		addMorphBack: aPage title asMorph;
		yourself
]

{ #category : #factory }
MorphicNotebookAdapter >> buildWidget [
	| notebookMorph |

	notebookMorph := NotebookMorph new
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		yourself.
	self addModelTo: notebookMorph.

	^ notebookMorph
]

{ #category : #updating }
MorphicNotebookAdapter >> updatePage: aPage [

	self widgetDo: [ :w |
		w 
			relabelPage: (w pages detect: [ :each | each model = aPage]) 
			with: (self buildLabelForPage: aPage) ] 
	
]
