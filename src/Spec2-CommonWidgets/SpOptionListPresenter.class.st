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
		'options'
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

	self selectedOption doAccept
]

{ #category : #initialization }
SpOptionListPresenter >> initialize [
	
	options := OrderedCollection new.
	
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
