"
I am a demo showing filtering lists examples
"
Class {
	#name : #SpDemoFilteringListsPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'listWithPackages',
		'listWithMethodsAlreadyFiltered',
		'selectableList'
	],
	#category : #'Spec2-Examples-Demo-Lists'
}

{ #category : #layout }
SpDemoFilteringListsPresenter >> defaultLayout [

	^ SpBoxLayout newLeftToRight
		add: (SpBoxLayout newTopToBottom
			add: 'Filtering List' expand: false;
			add: listWithPackages;
			yourself);
		add: (SpBoxLayout newTopToBottom
			add: 'Filtering List with Filter Text' expand: false;
			add: listWithMethodsAlreadyFiltered;
			yourself);
		add: (SpBoxLayout newTopToBottom
			add: 'Selectable Filtering List' expand: false;
			add: selectableList;
			yourself);
		yourself
]

{ #category : #initialization }
SpDemoFilteringListsPresenter >> initializePresenters [

	listWithPackages := self newFilteringList.
	listWithPackages items: self class environment allClasses.
	listWithPackages listPresenter
		display: [ :class | class name ];
		sortingBlock: [ :a : b | a name < b name ];
		displayIcon: [ :aClass | aClass systemIcon ].
	
	listWithMethodsAlreadyFiltered := self newFilteringList.
	listWithMethodsAlreadyFiltered
		items: self class environment allClasses;
		applyFilter: 'SpDemo'.
	
	listWithMethodsAlreadyFiltered listPresenter
		display: [ :class | class name ];
		sortingBlock: [ :a :b | a name < b name ];
		displayIcon: [ :aClass | aClass systemIcon ].
	
	selectableList :=  self instantiate: SpFilteringSelectableListPresenter.
	selectableList items: self class environment allClasses.
	selectableList listPresenter
		sortingBlock: [ :a :b | a name > b name ]
]
