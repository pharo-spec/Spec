"
I'm a presenter that has different options.
I'm an abstract class, I need to be used  through my children.

I'm kind of a ""tabbed"" dialog, but my options are ""mac style"": lateral and not top.

This is useful to keep a variable number of options.
You can evaluate this to have an example:
	self example
"
Class {
	#name : #SpOptionListPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'contentLayout',
		'optionsPresenter',
		'options',
		'acceptBlock'
	],
	#category : #'Spec2-CommonWidgets-Core'
}

{ #category : #examples }
SpOptionListPresenter class >> example [
	^ SpOptionListExample example
]

{ #category : #testing }
SpOptionListPresenter class >> isAbstract [
		
	^ self == SpOptionListPresenter
]

{ #category : #initialization }
SpOptionListPresenter >> addOption: anOptionPresenter [

	options addLast: anOptionPresenter
]

{ #category : #initialization }
SpOptionListPresenter >> addOptions: aListOfOptionPresenter [

	aListOfOptionPresenter do: [ :each | self addOption: each ]
]

{ #category : #initialization }
SpOptionListPresenter >> allOptions [

	^ options
]

{ #category : #accessing }
SpOptionListPresenter >> contentLayout [
	^ contentLayout
]

{ #category : #layout }
SpOptionListPresenter >> defaultLayout [ 
	
	^ SpPanedLayout newLeftToRight 
		positionOfSlider: 0.3;
		add: optionsPresenter;
		add: contentLayout;
		yourself
]

{ #category : #action }
SpOptionListPresenter >> doAccept [

	acceptBlock value: self selectedOption
]

{ #category : #initialization }
SpOptionListPresenter >> initialize [
	
	options := OrderedCollection new.
	acceptBlock := [ :selectedOption | selectedOption doAccept ].
	
	"options need to be initialized before Spec initialization"
	super initialize.
]

{ #category : #initialization }
SpOptionListPresenter >> initializeDialogWindow: aWindowPresenter [

	super initializeDialogWindow: aWindowPresenter.
	aWindowPresenter okAction: [ self doAccept ].
]

{ #category : #initialization }
SpOptionListPresenter >> initializePresenters [

	optionsPresenter := self newTable
		hideColumnHeaders;
		addColumn: ((SpImageTableColumn evaluated: #optionIcon) width: 20);
		addColumn: (SpStringTableColumn evaluated: #optionTitle);
		whenSelectionChangedDo: [ :selection | 
			self selectionChanged: selection selectedItem ];
		items: self allOptions;
		yourself.
	contentLayout := SpBoxLayout newTopToBottom.
		
	self whenBuiltDo: [ optionsPresenter selectFirst ].
]

{ #category : #'private - testing' }
SpOptionListPresenter >> optionAt: anIndex [
	^ optionsPresenter itemAt: anIndex
]

{ #category : #'private - testing' }
SpOptionListPresenter >> optionsPresenter [
	^ optionsPresenter
]

{ #category : #api }
SpOptionListPresenter >> selectIndex: anIndex [
	^ optionsPresenter selectIndex: anIndex 
]

{ #category : #selecting }
SpOptionListPresenter >> selectOptionAt: anIndex [

	^ optionsPresenter selectIndex: anIndex
]

{ #category : #accessing }
SpOptionListPresenter >> selectedOption [
	^ optionsPresenter selectedItem
]

{ #category : #'event handling' }
SpOptionListPresenter >> selectionChanged: anOption [

	anOption ifNil: [ ^ self ].
	
	contentLayout
		removeAll;
		add: anOption.
]

{ #category : #'api - events' }
SpOptionListPresenter >> whenAcceptedDo: aBlock [
	"aBlock will be executed when this presenter is open as a Dialog 
	AND when the Ok button of the dialog is clicked.
	aBlock must have one argument that will be the selected option in the option list presenter.
	WARNING: it will override the default behavior that is to senf #doAccept on the selected option."

	acceptBlock := aBlock
]
