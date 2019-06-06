"
AbstractBasicWidget is an abstract class for basic widgets

I collaborate with
- ValueHolder to managed some of my variables.
- ComposablePresenter to manage me with other elements.

I provide the following variables and their accessors
- enabled is a boolean representing if I am usable or not, it is true by default. It  have also shortcut enable and disable.
- help is the text displayed in the tooltip.
- borderWidth, its default value is 0, it must be called after have displayed the widget. 
- borderColor, its default value is transparent, it must be called after have displayed the widget. 

For the two methods borderWidth and borderColor, notice that some of my subclasses don't display my border

Me and my subclasses provide shortcut hook for my valueHolder, they are named ""when"" followed of the event.

My drag and drop system don't work well.

todo
- defaultColor
- color
- eventKeyStrokesForNextFocus

"
Class {
	#name : #AbstractWidgetPresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'#borderWidth => SpecObservableSlot',
		'#borderColor => SpecObservableSlot',
		'#dragEnabled => SpecObservableSlot',
		'#dropEnabled => SpecObservableSlot',
		'#dragTransformationBlock => SpecObservableSlot',
		'#wantDropBlock => SpecObservableSlot',
		'#acceptDropBlock => SpecObservableSlot',
		'#transferBlock => SpecObservableSlot',
		'#color => SpecObservableSlot',
		'#help => SpecObservableSlot',
		'#enabled => SpecObservableSlot'
	],
	#category : #'Spec-Core-Widgets'
}

{ #category : #specs }
AbstractWidgetPresenter class >> adapterName [

	^ self subclassResponsibility
]

{ #category : #specs }
AbstractWidgetPresenter class >> defaultSpec [
	<spec: #default>
	^ SpecAbstractWidgetLayout for: self adapterName
]

{ #category : #'drag and drop' }
AbstractWidgetPresenter >> acceptDropBlock [
	^ acceptDropBlock
]

{ #category : #'drag and drop' }
AbstractWidgetPresenter >> acceptDropBlock: aBlock [
	acceptDropBlock := aBlock
]

{ #category : #'drag and drop' }
AbstractWidgetPresenter >> acceptDroppingMorph: draggedMorph event: event inMorph: source [

	^ self acceptDropBlock cull: draggedMorph model model cull: event cull: source cull: source model 

]

{ #category : #api }
AbstractWidgetPresenter >> borderColor [
	"Return the border color"

	^ borderColor
]

{ #category : #api }
AbstractWidgetPresenter >> borderColor: aColor [
	"Set the border width"

	borderColor := aColor
]

{ #category : #api }
AbstractWidgetPresenter >> borderWidth [
	"Return the border width"

	^ borderWidth
]

{ #category : #api }
AbstractWidgetPresenter >> borderWidth: anInteger [
	"Set the border width"

	borderWidth := anInteger
]

{ #category : #api }
AbstractWidgetPresenter >> color [
	^ color
]

{ #category : #api }
AbstractWidgetPresenter >> color: aColor [
	^ color := aColor
]

{ #category : #initialization }
AbstractWidgetPresenter >> defaultColor [
	^ self theme backgroundColor
]

{ #category : #'drag and drop' }
AbstractWidgetPresenter >> defaultTransferFor: passenger from: source [

	^ TransferPresenter new
		transfer: passenger;
		from: source;
		yourself
]

{ #category : #api }
AbstractWidgetPresenter >> disable [
	"<api: #do>"
	"Disable the label"
	
	self enabled: false
]

{ #category : #'drag and drop' }
AbstractWidgetPresenter >> dragEnabled [
	^ dragEnabled
]

{ #category : #'drag and drop' }
AbstractWidgetPresenter >> dragEnabled: aBoolean [
	dragEnabled := aBoolean
]

{ #category : #'drag and drop' }
AbstractWidgetPresenter >> dragTransformationBlock [
	^ dragTransformationBlock
]

{ #category : #'drag and drop' }
AbstractWidgetPresenter >> dragTransformationBlock: aBlock [
	dragTransformationBlock := aBlock
]

{ #category : #'drag and drop' }
AbstractWidgetPresenter >> dropEnabled [
	^ dropEnabled
]

{ #category : #'drag and drop' }
AbstractWidgetPresenter >> dropEnabled: aBoolean [
	dropEnabled := aBoolean
]

{ #category : #api }
AbstractWidgetPresenter >> enable [
	"<api: #do>"
	"Enable the label"
	
	self enabled: true
]

{ #category : #api }
AbstractWidgetPresenter >> enabled: aBooleanOrValuable [
	"Set if the button is enabled (clickable).
	This can either be a boolean or a block returning a boolean."

	enabled := aBooleanOrValuable
]

{ #category : #'api-focus' }
AbstractWidgetPresenter >> eventKeyStrokesForNextFocus [
	"String describing the keystroke to perform to jump to the next widget"
	
	^ { Character arrowRight asKeyCombination. Character tab asKeyCombination}
]

{ #category : #'api-focus' }
AbstractWidgetPresenter >> eventKeyStrokesForPreviousFocus [
	"String describing the keystroke to perform to jump to the next widget"
	
	^ { Character arrowLeft asKeyCombination. Character tab shift asKeyCombination}
]

{ #category : #api }
AbstractWidgetPresenter >> help [
	"Return the help string to display as help to the user."

	^ help
]

{ #category : #api }
AbstractWidgetPresenter >> help: aString [
	"Set a help string to display to the user if he let the mouse over the widget."

	help := aString
]

{ #category : #initialization }
AbstractWidgetPresenter >> initialize [
	super initialize.

	help := nil.
	borderWidth := 0.
	borderColor := Color transparent.
	enabled := true.
	dragEnabled := false.
	dropEnabled := false.
	dragTransformationBlock := [ :item :source | item ].
	wantDropBlock := [ :draggedItem :event :source | self dropEnabled ].
	acceptDropBlock := [ :draggedItem :event :source |  ].
	transferBlock := [ :passenger :source | self defaultTransferFor: passenger from: source ].
	color := self defaultColor.
	self whenHelpChangedDo: [ :string | self withAdapterDo: [ :w | w update: #setBalloonText: with: {string} ] ].
	self whenBorderWidthChangedDo: [ :int | self withWidgetDo: [ :w | w update: #borderWidth: with: {int} ] ].
	self whenBorderColorChangedDo: [ :newColor | self withWidgetDo: [ :w | w update: #borderColor: with: {newColor} ] ].
	self property: #color whenChangedDo: [ :newColor | self withAdapterDo: [ :w | w update: #color: with: {newColor} ] ].
	self whenEnabledChangedDo: [ :b | self withAdapterDo: [ :w | w update: #enabled: with: {b} ] ].
	self property: #dragEnabled whenChangedDo: [ :b | self withWidgetDo: [ :w | w update: #dragEnabled: with: {b} ] ].
	self property: #dropEnabled whenChangedDo: [ :b | self withWidgetDo: [ :w | w update: #dropEnabled: with: {b} ] ]
]

{ #category : #initialization }
AbstractWidgetPresenter >> initializeWidgets [ 
	"ignore this method since there is no composition in basic widgets"
]

{ #category : #api }
AbstractWidgetPresenter >> isEnabled [
	^ enabled
]

{ #category : #'drag and drop' }
AbstractWidgetPresenter >> transferBlock [
	^ transferBlock
]

{ #category : #'drag and drop' }
AbstractWidgetPresenter >> transferBlock: aBlock [
	transferBlock := aBlock
]

{ #category : #'drag and drop' }
AbstractWidgetPresenter >> transferFor: passenger from: source [
	^ self transferBlock value: passenger value: source
]

{ #category : #'private-traversing' }
AbstractWidgetPresenter >> traversePresentersDo: aBlock excluding: excludes [
	"Terminate"

	excludes add: self.
	aBlock value: self
]

{ #category : #'drag and drop' }
AbstractWidgetPresenter >> wantDropBlock [
	^ wantDropBlock
]

{ #category : #'drag and drop' }
AbstractWidgetPresenter >> wantDropBlock: aBlock [
	wantDropBlock := aBlock
]

{ #category : #'drag and drop' }
AbstractWidgetPresenter >> wantsDroppedMorph: draggedMorph event: anEvent inMorph: source [
	draggedMorph isTransferable ifFalse: [ ^ false ].

	^ self wantDropBlock cull: draggedMorph passenger cull: anEvent cull: source
]

{ #category : #'api-events' }
AbstractWidgetPresenter >> whenBorderColorChangedDo: aBlock [
	"Set a block to be performed when the brder width changed"

	self property: #borderColor whenChangedDo: aBlock
]

{ #category : #'api-events' }
AbstractWidgetPresenter >> whenBorderWidthChangedDo: aBlock [
	"Set a block to be performed when the brder width changed"

	self property: #borderWidth whenChangedDo: aBlock
]

{ #category : #'api-events' }
AbstractWidgetPresenter >> whenEnabledChangedDo: aBlock [
	"Set a block to performed when the widget is enabled or disabled"

	self property: #enabled whenChangedDo: aBlock
]

{ #category : #'api-events' }
AbstractWidgetPresenter >> whenHelpChangedDo: aBlock [
	"Set a block to be performed when the help changed"

	self property: #help whenChangedDo: aBlock
]
