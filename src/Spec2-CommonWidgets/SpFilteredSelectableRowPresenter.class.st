"
This is a row presenter to be used on `SpFilteredSelectableListPresenter`.  
In addition to a label and an optional icon, it shows a checkbox to perform the select.  

IMPORTANT! It requires a `stateProvider` that understands `isActive:`, `activateItem:` and `deactivateItem`
"
Class {
	#name : 'SpFilteredSelectableRowPresenter',
	#superclass : 'SpEasyListRowPresenter',
	#instVars : [
		'checkboxPresenter',
		'stateProvider'
	],
	#category : 'Spec2-CommonWidgets-Core',
	#package : 'Spec2-CommonWidgets',
	#tag : 'Core'
}

{ #category : 'private - actions' }
SpFilteredSelectableRowPresenter >> doActivate [

	stateProvider activateItem: self model
]

{ #category : 'private - actions' }
SpFilteredSelectableRowPresenter >> doDeactivate [

	stateProvider deactivateItem: self model
]

{ #category : 'private - actions' }
SpFilteredSelectableRowPresenter >> doToggleSelection [

	(stateProvider isActive: self model)
		ifTrue: [ self doDeactivate ]
		ifFalse: [ self doActivate ].
	self updatePresenter
]

{ #category : 'layout' }
SpFilteredSelectableRowPresenter >> iconLayout [

	^ SpBoxLayout newLeftToRight
		spacing: 5;
		add: checkboxPresenter expand: false;
		add: iconPresenter expand: false;
		add: textPresenter;
		yourself
]

{ #category : 'initialization' }
SpFilteredSelectableRowPresenter >> initializePresenters [
	
	super initializePresenters.
	
	checkboxPresenter := self newCheckBox
		addStyle: 'compact';
		whenActivatedDo: [ self doActivate ];
		whenDeactivatedDo: [ self doDeactivate ];
		yourself.
		
	self eventHandler whenMouseDownDo: [ :event |
		self doToggleSelection.
		event wasHandled: false ]
]

{ #category : 'testing' }
SpFilteredSelectableRowPresenter >> isActive [

	^ stateProvider isActive: self model
]

{ #category : 'accessing' }
SpFilteredSelectableRowPresenter >> stateProvider: aStateProvider [

	stateProvider := aStateProvider
]

{ #category : 'layout' }
SpFilteredSelectableRowPresenter >> textLayout [

	^ SpBoxLayout newLeftToRight
		spacing: 5;
		add: checkboxPresenter expand: false;
		add: textPresenter;
		yourself
]

{ #category : 'initialization' }
SpFilteredSelectableRowPresenter >> updatePresenter [

	self model ifNil: [ ^ self ].
	
	super updatePresenter.
	checkboxPresenter state: (stateProvider isActive: self model)
]
