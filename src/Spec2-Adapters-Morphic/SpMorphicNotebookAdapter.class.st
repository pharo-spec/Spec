"
I'm an adapter to show a notebook (a tab manager)
"
Class {
	#name : #SpMorphicNotebookAdapter,
	#superclass : #SpAbstractMorphicAdapter,
	#traits : 'SpTBackendUpdating',
	#classTraits : 'SpTBackendUpdating classTrait',
	#category : #'Spec2-Adapters-Morphic-Base'
}

{ #category : #'table defaults' }
SpMorphicNotebookAdapter class >> cellInset [ 

	^ 3
]

{ #category : #initialization }
SpMorphicNotebookAdapter >> addFocusRotationKeyBindings [

	self widget tabSelectorMorph
		bindKeyCombination: Character tab asKeyCombination 
			toAction: [ self focusNext ];
		bindKeyCombination: Character tab shift asKeyCombination 
			toAction: [ self focusPrevious ]
]

{ #category : #factory }
SpMorphicNotebookAdapter >> addModelTo: aNotebook [
	
	self presenter pages ifEmpty: [ ^ self ].
	self presenter pages do: [ :each | 
		"Since I do not have the page added, I need to take it from the list. 
		 But I know this will be the last added :)" 
		self addPage: each to: aNotebook ].
	"force first page to be drawn"
	self presenter selectedPage ifNil: [ self presenter selectPageIndex: 1 ].
	aNotebook selectedPageIndex: self presenter selectedPageIndex.
	aNotebook announcer 
		when: SpNotebookPageChanged 
		send: #pageChanged: 
		to: self
]

{ #category : #factory }
SpMorphicNotebookAdapter >> addPage: aNotebookPage to: aNotebook [

	aNotebook 
		addLazyPage: [ self buildContentForPage: aNotebookPage ] 
		label: (self buildLabelForPage: aNotebookPage)
		model: aNotebookPage.
	"Since I do not have the page added, I need to take it from the list. But I know 
	 this will be the last added :)"
	aNotebook pages last model: aNotebookPage
]

{ #category : #factory }
SpMorphicNotebookAdapter >> buildContentForPage: aPage [

	^ aPage retrievePresenter ifNotNil: [ :presenter |
		self ensurePage: aPage isBuiltWithPresenter: presenter.
		presenter adapter widget ]
]

{ #category : #factory }
SpMorphicNotebookAdapter >> buildLabelForPage: aPage [
	"I cannot use a PanelMorph here (as I would like) because Panels have bg colors setted 
	 from theme (and then... they look always same in the tab)"
	| labelMorph |
	
	labelMorph := Morph new 
		changeTableLayout;
		vResizing: #spaceFill;
		hResizing: #shrinkWrap;
		cellInset: self class cellInset;
		color: Color transparent;
		listDirection: #leftToRight;
		yourself.
		
	aPage icon ifNotNil: [ :icon |
		labelMorph addMorphBack: (icon asMorph) ].
	labelMorph addMorphBack: aPage title asMorph.
	
	^ labelMorph
]

{ #category : #factory }
SpMorphicNotebookAdapter >> buildWidget [
	| notebookMorph |

	notebookMorph := SpNotebookMorph new
		vResizing: #spaceFill;
		hResizing: #spaceFill;
		setBalloonText: self help;
		yourself.
	self addModelTo: notebookMorph.

	self presenter 
		whenPagesChangedDo: [ :pages | self updatePagesWith: pages ];
		whenSelectedPageChangedDo: [ :page | self selectPage: page ].

	^ notebookMorph
]

{ #category : #factory }
SpMorphicNotebookAdapter >> ensurePage: aPage isBuiltWithPresenter: presenter [

	"is already built *for this notebook (owner)*"
	(presenter hasAdapter 
		and: [ presenter owner = self presenter ])
		ifTrue: [ ^ self ].

	"if not built or not same owner, I need to rebuild"		
	presenter owner: self presenter. 
	aPage layoutSpec
		ifNil: [ presenter buildWithSpec ]
		ifNotNil: [ :spec | presenter buildWithSpec: spec ]
]

{ #category : #initialization }
SpMorphicNotebookAdapter >> initialize [

	super initialize.
	self initializeTBackendUpdating
]

{ #category : #private }
SpMorphicNotebookAdapter >> pageChanged: ann [

	self backendUpdatingDo: [ self presenter selectPage: ann page model ]
	
]

{ #category : #updating }
SpMorphicNotebookAdapter >> selectPage: aPage [

	self widgetDo: [ :w | 
		w page: (aPage ifNotNil: [ (w pageWithModel: aPage) ]) ]
]

{ #category : #protocol }
SpMorphicNotebookAdapter >> takeKeyboardFocus [

	self widget tabSelectorMorph takeKeyboardFocus
]

{ #category : #updating }
SpMorphicNotebookAdapter >> updatePageContent: aPage [

	self widgetDo: [ :w |
		(w pageWithModel: aPage) reset.
		"if we are updating the page being displayed, we need to trigger a refresh"
		aPage = self presenter selectedPage ifTrue: [ 
			w updatePageIndex: (self model selectedPageIndex) ] ]
]

{ #category : #updating }
SpMorphicNotebookAdapter >> updatePageTitle: aPage [

	self widgetDo: [ :w |
		w 
			relabelPage: (w pageWithModel: aPage) 
			with: (self buildLabelForPage: aPage) ]
]

{ #category : #updating }
SpMorphicNotebookAdapter >> updatePagesWith: aCollection [
	| pagesToRemove |
	
	self widget ifNil: [ ^ self ].
		
	pagesToRemove := self widget pages reject: [ :pageMorph | 
		aCollection anySatisfy: [ :page | page = pageMorph model ] ].
	pagesToRemove do: [ :pageMorph | self widget removePage: pageMorph ].
	aCollection 
		reject: [ :page | self widget hasPageWithModel: page ] 
		thenDo: [ :page | self addPage: page to: self widget ]
]
