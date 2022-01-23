"
I am a presenter that is used to choose items from a list. `SpChooserPresenter>>#chosenItems` returns the chosen items. View the examples on the class side.
Note that all the items are sorted according to the displayBlock that is provided by my users. If non block is provided, the default displayBlock of `SpListPresenter` is used. This widget is in work in progress so it will improved to be more fast and not sort the items everytime.
"
Class {
	#name : #SpChooserPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'buttonBarLayout',
		'sourceList',
		'targetList',
		'displayBlock',
		'sourceItems'
	],
	#category : #'Spec2-CommonWidgets'
}

{ #category : #examples }
SpChooserPresenter class >> example [

	^ (self sourceItems: self package definedClasses asOrderedCollection)
		  open
]

{ #category : #examples }
SpChooserPresenter class >> exampleClasses [

	^ (self
		   sourceItems: { SpChooserPresenter . SpFilteringListPresenter }
		   chosenItems: { SpFilteringSelectableListPresenter }
		   displayBlock: #name) open
]

{ #category : #examples }
SpChooserPresenter class >> examplePackages [

	^ (self
		   sourceItems: RPackageOrganizer default packages
		   chosenItems:
		   { (RPackageOrganizer default packageNamed: 'Spec2-CommonWidgets') }
		   displayBlock: #packageName) open
]

{ #category : #'instance creation' }
SpChooserPresenter class >> sourceItems: sourceItems [

	^ self new
		  sourceItems: sourceItems;
		  yourself
]

{ #category : #'instance creation' }
SpChooserPresenter class >> sourceItems: sourceItems chosenItems: selectedItems [

	^ self new
		  sourceItems: sourceItems;
		  defaultChosenItems: selectedItems;
		  yourself
]

{ #category : #'instance creation' }
SpChooserPresenter class >> sourceItems: sourceItems chosenItems: selectedItems displayBlock: displayBlock [

	^ self new
		  displayBlock: displayBlock;
		  sourceItems: sourceItems;
		  defaultChosenItems: selectedItems;
		  yourself
]

{ #category : #'instance creation' }
SpChooserPresenter class >> sourceItems: sourceItems displayBlock: displayBlock [

	^ self new
		  displayBlock: displayBlock;
		  sourceItems: sourceItems;
		  yourself
]

{ #category : #specs }
SpChooserPresenter class >> title [

	^ 'Choose items'
]

{ #category : #actions }
SpChooserPresenter >> addAll [

	| newSourceItems |
	targetList items: targetList unfilteredItems , sourceList items.
	newSourceItems := sourceItems asOrderedCollection.
	newSourceItems removeAllFoundIn: targetList unfilteredItems.
	sourceList items: newSourceItems.
	self resetSelectedItems.
	self sortLists
]

{ #category : #actions }
SpChooserPresenter >> addSelected [

	| newSourceItems |
	targetList items:
		targetList unfilteredItems , sourceList selectedItems.
	newSourceItems := sourceItems copy asOrderedCollection.
	newSourceItems removeAllFoundIn: targetList unfilteredItems.
	sourceList items: newSourceItems.
	self resetSelectedItems.
	self sortLists
]

{ #category : #accessing }
SpChooserPresenter >> chosenItems [

	^ targetList unfilteredItems
]

{ #category : #accessing }
SpChooserPresenter >> defaultChosenItems: aCollection [

	| newItems |
	targetList items: aCollection.
	newItems := sourceList unfilteredItems copy asOrderedCollection.
	newItems removeAllFoundIn: aCollection.
	sourceList items: newItems.
	self sortLists
]

{ #category : #initialization }
SpChooserPresenter >> defaultLayout [

	^ SpBoxLayout newLeftToRight
			 spacing: 5;
			 add: #sourceList;
			 add: buttonBarLayout expand: false;
			 add: #targetList;
			 yourself
]

{ #category : #accessing }
SpChooserPresenter >> displayBlock: aBlock [

	displayBlock := aBlock.
	sourceList display: aBlock.
	targetList display: aBlock
]

{ #category : #initialization }
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

{ #category : #initialization }
SpChooserPresenter >> initializeLists [

	sourceList := self instantiate: SpFilteringSelectableListPresenter.
	targetList := self instantiate: SpFilteringSelectableListPresenter.
	displayBlock := sourceList display
]

{ #category : #initialization }
SpChooserPresenter >> initializePresenters [

	self initializeLists.
	self initializeButtonBarLayout.
]

{ #category : #actions }
SpChooserPresenter >> removeAll [

	| newTargetItems |
	sourceList items: targetList items , sourceList unfilteredItems.
	newTargetItems := targetList unfilteredItems copy asOrderedCollection.
	newTargetItems removeAllFoundIn: sourceList unfilteredItems.
	targetList items: newTargetItems.
	self resetSelectedItems.
	self sortLists
]

{ #category : #actions }
SpChooserPresenter >> removeSelected [

	| newTargetItems |
	sourceList items:
		sourceList unfilteredItems , targetList selectedItems.
	newTargetItems := targetList unfilteredItems copy asOrderedCollection.
	newTargetItems removeAllFoundIn: targetList selectedItems.
	targetList items: newTargetItems.
	self resetSelectedItems.
	self sortLists
]

{ #category : #actions }
SpChooserPresenter >> resetSelectedItems [
	
	sourceList selectItems: #().
	targetList selectItems: #().
]

{ #category : #actions }
SpChooserPresenter >> sortLists [

	self sortSourceList.
	self sortTargetList
]

{ #category : #actions }
SpChooserPresenter >> sortSourceList [

	sourceList items: (sourceList items sorted: displayBlock ascending)
]

{ #category : #actions }
SpChooserPresenter >> sortTargetList [

	targetList items: (targetList items sorted: displayBlock ascending)
]

{ #category : #accessing }
SpChooserPresenter >> sourceItems: aCollection [

	sourceItems := aCollection.
	sourceList items: aCollection.
	self sortLists
]

{ #category : #accessing }
SpChooserPresenter >> sourceList [

	^ sourceList
]

{ #category : #accessing }
SpChooserPresenter >> targetList [

	^ targetList
]
