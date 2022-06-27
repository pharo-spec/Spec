"
Add column decoration capabilities to users.
A column can be decorated with certain attributes (see selectors defined) that receive a valuable. 

The valuable is always in the form [ :anItem | aResult ], but result may vary depending on the decoration (explained in messages).
"
Trait {
	#name : #SpTDecoratedColumn,
	#instVars : [
		'colorAction',
		'backgroundColorAction',
		'italicAction',
		'boldAction',
		'underlineAction',
		'alignmentAction'
	],
	#category : #'Spec2-Core-Widgets-Table'
}

{ #category : #api }
SpTDecoratedColumn >> displayAlignment [

	^ alignmentAction
]

{ #category : #api }
SpTDecoratedColumn >> displayAlignment: aBlock [
	"aBlock must return an instance of `SpColumnAlignment`"

	alignmentAction := aBlock
]

{ #category : #api }
SpTDecoratedColumn >> displayBackgroundColor [

	^ backgroundColorAction
]

{ #category : #api }
SpTDecoratedColumn >> displayBackgroundColor: aBlock [
	"Changes the background color of cells of the column. 
	 `aBlock` receives an argument (the model element) and should answer an instance of Color. 
	 NOTE: This may be not working at the moment :("

	backgroundColorAction := aBlock
]

{ #category : #api }
SpTDecoratedColumn >> displayBold [

	^ boldAction
]

{ #category : #api }
SpTDecoratedColumn >> displayBold: aBlock [
	"If `aBlock` answer true, the cell will be displayed in bold.
	 `aBlock` receives one argument (the model element)."

	boldAction := aBlock
]

{ #category : #api }
SpTDecoratedColumn >> displayColor [

	^ colorAction
]

{ #category : #api }
SpTDecoratedColumn >> displayColor: aBlock [
	"Changes the font color of cells of the column. 
	 `aBlock` receives an argument (the model element) and should answer an instance of Color."

	colorAction := aBlock
]

{ #category : #api }
SpTDecoratedColumn >> displayItalic [

	^ italicAction
]

{ #category : #api }
SpTDecoratedColumn >> displayItalic: aBlock [
	"If `aBlock` answer true, the cell will be displayed in italic.
	 `aBlock` receives one argument (the model element)."

	italicAction := aBlock
]

{ #category : #api }
SpTDecoratedColumn >> displayUnderline [

	^ underlineAction
]

{ #category : #api }
SpTDecoratedColumn >> displayUnderline: aBlock [
	"If `aBlock` answer true, the cell will be displayed underlined.
	 `aBlock` receives one argument (the model element)."

	underlineAction := aBlock
]
