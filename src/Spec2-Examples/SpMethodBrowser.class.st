"
A MethodBrowser is a simple browser using Spec to display a list of methods and their source code

self example
"
Class {
	#name : #SpMethodBrowser,
	#superclass : #SpComposablePresenter,
	#instVars : [
		'listModel',
		'textModel',
		'toolbarModel'
	],
	#category : #'Spec2-Examples-Standalone'
}

{ #category : #specs }
SpMethodBrowser class >> defaultSpec [
	<spec>
	| delta |
	delta := 15.
	^ SpLayout composed 
			add: #listModel origin: 0@0 corner: 1@0.5 offsetOrigin: 0@0 offsetCorner: 0@(delta negated);
			add: #toolbarModel origin: 0@0.5 corner: 1@0.5 offsetOrigin: 0@(delta negated) offsetCorner: 0@delta;
			add: #textModel origin: 0@0.5 corner: 1@1 offsetOrigin: 0@delta offsetCorner: 0@0;
			yourself
]

{ #category : #specs }
SpMethodBrowser class >> defaultSpec2 [
^{ #Panel.
		#changeTableLayout.
		#listDirection:. 	#bottomToTop.
		#addMorph:. 		{#presenter. #listModel.}.
		#addMorph:. 		{#presenter. #textModel.}.
		#vResizing:.		 #spaceFill.
		#hResizing:.		 #spaceFill.}
]

{ #category : #example }
SpMethodBrowser class >> example [
	<sampleInstance>
	| example |
	example := SpMethodBrowser new.
	example methods: Object methods;
	 openWithSpec.
	^example
]

{ #category : #specs }
SpMethodBrowser class >> title [

	^ 'Method Browser'
]

{ #category : #accessing }
SpMethodBrowser >> acceptBlock: aBlock [

	textModel acceptBlock: aBlock
]

{ #category : #accessing }
SpMethodBrowser >> action [

	^ textModel actionToPerformHolder content
]

{ #category : #api }
SpMethodBrowser >> displayBlock: aBlock [

	listModel displayBlock: aBlock
]

{ #category : #initialization }
SpMethodBrowser >> initializePresenter [
	listModel
		whenSelectionChangedDo: [ :selection | 
			selection isEmpty
				ifTrue: [ textModel text: ''.
					textModel behavior: nil.
					toolbarModel method: nil ]
				ifFalse: [ | m |
					m := selection selectedItem. 
					textModel text: m sourceCode.
					textModel behavior: m methodClass.
					toolbarModel method: m ] ].
	self acceptBlock: [ :t | self listModel selectedItem inspect ].
	self
		wrapWith: [ :item | item methodClass name , '>>#' , item selector ]
]

{ #category : #initialization }
SpMethodBrowser >> initializeWidgets [
	listModel := self instantiate: SpListPresenter .
	textModel := self newCode.
	toolbarModel := self instantiate: SpMethodToolbar.
	self focusOrder
		add: listModel;
		add: toolbarModel;
		add: textModel
]

{ #category : #accessing }
SpMethodBrowser >> listModel [

	^ listModel
]

{ #category : #api }
SpMethodBrowser >> methods: aList [

	"Here I reroute my entry point to the list model's entry point"
	self listModel items: aList
]

{ #category : #api }
SpMethodBrowser >> sortingBlock: aBlock [ 

	listModel sortingBlock: aBlock 
]

{ #category : #focus }
SpMethodBrowser >> takeKeyboardFocus [

	^ self listModel takeKeyboardFocus
]

{ #category : #accessing }
SpMethodBrowser >> textModel [

	^ textModel
]

{ #category : #accessing }
SpMethodBrowser >> toolbarModel [

	^ toolbarModel
]

{ #category : #api }
SpMethodBrowser >> wrapWith: aBlock [

	listModel displayBlock: aBlock
]
