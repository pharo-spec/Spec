"
Add column decoration capabilities to users.
A column can be decorated with certain attributes (see selectors defined) that receive a valuable. 

The valuable is always in the form [ :anItem | aResult ], but result may vary depending on the decoration (explained in messages).
"
Trait {
	#name : 'SpTDecoratedText',
	#instVars : [
		'colorAction',
		'backgroundColorAction',
		'italicAction',
		'boldAction',
		'underlineAction'
	],
	#category : 'Spec2-Core-Widgets-Table',
	#package : 'Spec2-Core',
	#tag : 'Widgets-Table'
}

{ #category : 'api' }
SpTDecoratedText >> displayBackgroundColor [

	^ backgroundColorAction
]

{ #category : 'api' }
SpTDecoratedText >> displayBackgroundColor: aBlock [
	"Changes the background color of cells of the column. 
	 `aBlock` receives an argument (the model element) and should answer an instance of Color. 
	 NOTE: This may be not working at the moment :("

	backgroundColorAction := aBlock
]

{ #category : 'api' }
SpTDecoratedText >> displayBold [

	^ boldAction
]

{ #category : 'api' }
SpTDecoratedText >> displayBold: aBlock [
	"If `aBlock` answer true, the cell will be displayed in bold.
	 `aBlock` receives one argument (the model element)."

	boldAction := aBlock
]

{ #category : 'api' }
SpTDecoratedText >> displayColor [

	^ colorAction
]

{ #category : 'api' }
SpTDecoratedText >> displayColor: aBlock [
	"Changes the font color of cells of the column. 
	 `aBlock` receives an argument (the model element) and should answer an instance of Color."

	colorAction := aBlock
]

{ #category : 'api' }
SpTDecoratedText >> displayItalic [

	^ italicAction
]

{ #category : 'api' }
SpTDecoratedText >> displayItalic: aBlock [
	"If `aBlock` answer true, the cell will be displayed in italic.
	 `aBlock` receives one argument (the model element)."

	italicAction := aBlock
]

{ #category : 'api' }
SpTDecoratedText >> displayUnderline [

	^ underlineAction
]

{ #category : 'api' }
SpTDecoratedText >> displayUnderline: aBlock [
	"If `aBlock` answer true, the cell will be displayed underlined.
	 `aBlock` receives one argument (the model element)."

	underlineAction := aBlock
]
