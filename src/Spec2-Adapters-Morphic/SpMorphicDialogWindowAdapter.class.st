"
I am the adapter used to bridge a DialogWindowPresenter and a DialogWindow
"
Class {
	#name : 'SpMorphicDialogWindowAdapter',
	#superclass : 'SpMorphicWindowAdapter',
	#category : 'Spec2-Adapters-Morphic-Base',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Base'
}

{ #category : 'private' }
SpMorphicDialogWindowAdapter >> addButtonsDecorationTo: widgetToBuild [

	widgetToBuild setToolbarFrom: [ self buildButtonBar ].
	self model buttons ifNotEmpty: [ 
		self presenter defaultButton 
			ifNotNil: [ :aButton | aButton adapter setAsDefault ] ]
]

{ #category : 'private' }
SpMorphicDialogWindowAdapter >> addPresenterIn: widgetToBuild withSpecLayout: aSpec [
	"I replace the mainPanel (which contains contents and button bar) because like that I get the 
	 status bar at the end (where it belongs)"

	super addPresenterIn: widgetToBuild withSpecLayout: aSpec.
	self presenter hasButtonDecorations 
		ifTrue: [ self addButtonsDecorationTo: widgetToBuild ].
	self presenter whenButtonDecorationsChangedDo: [ :aBoolean |
		aBoolean 
			ifTrue: [ self addButtonsDecorationTo: widgetToBuild ]
			ifFalse: [ widgetToBuild removeToolbar ] ]
]

{ #category : 'factory' }
SpMorphicDialogWindowAdapter >> buildButtonBar [
	| buttonBar |

	buttonBar := (SpButtonBarPresenter owner: self model) placeAtEnd.
	self model buttons 
		do: [ :buttonPresenter | buttonBar add: buttonPresenter ].

	^ buttonBar
]

{ #category : 'factory' }
SpMorphicDialogWindowAdapter >> buildWidget [

	^ SpDialogWindowMorph new
		  model: self model;
		  in: [ :this | self subscribeToAnnouncements: this ];
		  yourself
]
