"
I am a presenter that is used to choose items from a list. `SpChooserPresenter>>#chosenItems` returns the chosen items. View the examples on the class side.
Note that all the items are sorted according to the displayBlock that is provided by my users. If non block is provided, the default displayBlock of `SpListPresenter` is used. This widget is in work in progress so it will improved to be more fast and not sort the items everytime.
"
Class {
	#name : 'SpChooserPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'buttonBarLayout',
		'sourceLabel',
		'sourceList',
		'targetLabel',
		'targetList'
	],
	#category : 'Spec2-CommonWidgets-Core',
	#package : 'Spec2-CommonWidgets',
	#tag : 'Core'
}

{ #category : 'default values' }
SpChooserPresenter class >> defaultSourceLabel [

	^ 'Available items' translated
]

{ #category : 'default values' }
SpChooserPresenter class >> defaultTargetLabel [

	^ 'Selected items' translated
]

{ #category : 'examples' }
SpChooserPresenter class >> example [

	^ (self sourceItems: self package definedClasses asOrderedCollection)
		  open
]

{ #category : 'examples' }
SpChooserPresenter class >> exampleClasses [

	^ (self
		   sourceItems: { SpChooserPresenter . SpFilteringListPresenter }
		   chosenItems: { SpFilteringSelectableListPresenter }
		   displayBlock: #name) open
]

{ #category : 'examples' }
SpChooserPresenter class >> examplePackages [

	^ (self
		sourceItems: self packageOrganizer packages
		chosenItems: { (self packageOrganizer packageNamed: 'Spec2-CommonWidgets') }
		displayBlock: #packageName)
		  open
]

{ #category : 'instance creation' }
SpChooserPresenter class >> sourceItems: sourceItems [

	^ self new
		  sourceItems: sourceItems;
		  yourself
]

{ #category : 'instance creation' }
SpChooserPresenter class >> sourceItems: sourceItems chosenItems: selectedItems [

	^ self new
		  sourceItems: sourceItems;
		  defaultChosenItems: selectedItems;
		  yourself
]

{ #category : 'instance creation' }
SpChooserPresenter class >> sourceItems: sourceItems chosenItems: selectedItems displayBlock: displayBlock [

	^ self new
		  displayBlock: displayBlock;
		  sourceItems: sourceItems;
		  defaultChosenItems: selectedItems;
		  yourself
]

{ #category : 'instance creation' }
SpChooserPresenter class >> sourceItems: sourceItems displayBlock: displayBlock [

	^ self new
		  displayBlock: displayBlock;
		  sourceItems: sourceItems;
		  yourself
]

{ #category : 'specs' }
SpChooserPresenter class >> title [

	^ 'Choose items'
]

{ #category : 'actions' }
SpChooserPresenter >> addAll [

	self moveAllFrom: sourceList to: targetList
]

{ #category : 'actions' }
SpChooserPresenter >> addSelected [

	self moveSelectedFrom: sourceList to: targetList
]

{ #category : 'accessing' }
SpChooserPresenter >> chosenItems [

	^ targetList unfilteredItems
]

{ #category : 'accessing' }
SpChooserPresenter >> defaultChosenItems: aCollection [

	targetList items: aCollection.
	sourceList items: sourceList unfilteredItems \ aCollection
]

{ #category : 'layout' }
SpChooserPresenter >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		  spacing: 5;
		  add: (SpBoxLayout newTopToBottom
				   spacing: 1;
				   add: #sourceLabel expand: false;
				   add: #sourceList;
				   yourself);
		  add: buttonBarLayout expand: false;
		  add: (SpBoxLayout newTopToBottom
				   spacing: 1;
				   add: #targetLabel expand: false;
				   add: #targetList;
				   yourself);
		  yourself
]

{ #category : 'accessing' }
SpChooserPresenter >> displayBlock: aBlock [

	sourceList display: aBlock.
	targetList display: aBlock.
	self initializeSortingBlocks
]

{ #category : 'initialization' }
SpChooserPresenter >> initializeButtonBarLayout [

	| addButton addAllButton removeButton removeAllButton |
	addButton := self newButton
		             addStyle: 'small';
		             label: '>';
		             help: 'Add selected items.';
		             action: [ self addSelected ];
		             yourself.
	addAllButton := self newButton
		                addStyle: 'small';
		                label: '>>';
		                help: 'Add all items.';
		                action: [ self addAll ];
		                yourself.
	removeButton := self newButton
		                addStyle: 'small';
		                label: '<';
		                help: 'Remove selected items.';
		                action: [ self removeSelected ];
		                yourself.
	removeAllButton := self newButton
		                   addStyle: 'small';
		                   label: '<<';
		                   help: 'Remove all items.';
		                   action: [ self removeAll ];
		                   yourself.

	buttonBarLayout := SpBoxLayout newTopToBottom
		                   spacing: 5;
		                   yourself.
	buttonBarLayout
		add: SpNullPresenter new expand: true;
		add: addButton expand: false;
		add: addAllButton expand: false;
		add: removeButton expand: false;
		add: removeAllButton expand: false;
		add: SpNullPresenter new expand: true
]

{ #category : 'initialization' }
SpChooserPresenter >> initializeLists [

	sourceList := self instantiate: SpFilteringSelectableListPresenter.
	targetList := self instantiate: SpFilteringSelectableListPresenter.
	self initializeSortingBlocks
]

{ #category : 'initialization' }
SpChooserPresenter >> initializePresenters [

	sourceLabel := self newLabel label: self class defaultSourceLabel.
	targetLabel := self newLabel label: self class defaultTargetLabel.
	self initializeLists.
	self initializeButtonBarLayout
]

{ #category : 'initialization' }
SpChooserPresenter >> initializeSortingBlocks [

	| sortingBlock |
	sortingBlock := sourceList display ascending.
	sourceList sortingBlock: sortingBlock.
	targetList sortingBlock: sortingBlock
]

{ #category : 'private' }
SpChooserPresenter >> moveAllFrom: fromList to: toList [

	| newFromListItems |
	toList items: toList unfilteredItems , fromList items.
	newFromListItems := OrderedCollection withAll:
		                    fromList unfilteredItems.
	newFromListItems removeAllFoundIn: fromList items.
	fromList items: newFromListItems
]

{ #category : 'private' }
SpChooserPresenter >> moveSelectedFrom: fromList to: toList [

	| newFromListItems |
	toList items: toList unfilteredItems , fromList selectedItems.
	newFromListItems := OrderedCollection withAll: fromList unfilteredItems.
	newFromListItems removeAllFoundIn: fromList selectedItems.
	fromList items: newFromListItems
]

{ #category : 'actions' }
SpChooserPresenter >> removeAll [

	self moveAllFrom: targetList to: sourceList
]

{ #category : 'actions' }
SpChooserPresenter >> removeSelected [

	self moveSelectedFrom: targetList to: sourceList
]

{ #category : 'actions' }
SpChooserPresenter >> resetSelectedItems [
	
	sourceList selectItems: #().
	targetList selectItems: #().
]

{ #category : 'accessing' }
SpChooserPresenter >> sourceItems: aCollection [

	sourceList items: aCollection
]

{ #category : 'accessing' }
SpChooserPresenter >> sourceLabel [

	^ sourceLabel label
]

{ #category : 'accessing' }
SpChooserPresenter >> sourceLabel: aString [

	sourceLabel label: aString
]

{ #category : 'accessing' }
SpChooserPresenter >> sourceList [

	^ sourceList
]

{ #category : 'accessing' }
SpChooserPresenter >> targetLabel [

	^ targetLabel label
]

{ #category : 'accessing' }
SpChooserPresenter >> targetLabel: aString [

	targetLabel label: aString
]

{ #category : 'accessing' }
SpChooserPresenter >> targetList [

	^ targetList
]
