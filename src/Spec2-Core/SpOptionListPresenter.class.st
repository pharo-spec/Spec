"
I'm a presenter that has different options.
I'm an abstract class, I need to be used  through my children.

I'm kind of a ""tabbed"" dialog, but my options are ""mac style"": lateral and not top.

This is useful to keep a variable number of options.
You can evaluate this to have an example:
	SpOptionListExample example
"
Class {
	#name : #SpOptionListPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'options',
		'contentLayout'
	],
	#category : #'Spec2-Core-Widgets-Advanced'
}

{ #category : #testing }
SpOptionListPresenter class >> isAbstract [
		
	^ self == SpOptionListPresenter
]

{ #category : #initialization }
SpOptionListPresenter >> allOptions [

	^ self subclassResponsibility
]

{ #category : #accessing }
SpOptionListPresenter >> contentLayout [
	^ contentLayout
]

{ #category : #layout }
SpOptionListPresenter >> defaultLayout [ 
	
	^ SpPanedLayout newLeftToRight 
		positionOfSlider: 0.3;
		add: options;
		add: contentLayout;
		yourself
]

{ #category : #initialization }
SpOptionListPresenter >> initializePresenters [

	options := self newTable
		hideColumnHeaders;
		addColumn: ((SpImageTableColumn evaluated: #optionIcon) width: 20);
		addColumn: (SpStringTableColumn evaluated: #optionTitle);
		whenSelectionChangedDo: [ :selection | 
			self selectionChanged: selection selectedItem ];
		items: self allOptions;
		yourself.
	contentLayout := SpBoxLayout newTopToBottom.
		
	self flag: 'TODO To remove when initializeLayout will be part of Spec2'.
	self layout: self defaultLayout.
]

{ #category : #'private - testing' }
SpOptionListPresenter >> optionAt: anIndex [
	^ options at: anIndex
]

{ #category : #'private - testing' }
SpOptionListPresenter >> options [
	^ options
]

{ #category : #api }
SpOptionListPresenter >> selectIndex: anIndex [
	^ options selectIndex: anIndex 
]

{ #category : #'event handling' }
SpOptionListPresenter >> selectionChanged: anOption [

	anOption ifNil: [ ^ self ].
	
	contentLayout
		removeAll;
		add: anOption.
]
