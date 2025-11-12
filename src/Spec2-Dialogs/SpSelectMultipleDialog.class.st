"
A dialog that allow the users to select multiple choices from a list of `items`
"
Class {
	#name : 'SpSelectMultipleDialog',
	#superclass : 'SpAbstractCancelableMessageDialog',
	#instVars : [
		'table1',
		'selectedItems',
		'display',
		'icon'
	],
	#category : 'Spec2-Dialogs',
	#package : 'Spec2-Dialogs'
}

{ #category : 'accessing' }
SpSelectMultipleDialog class >> defaultExtent [

	^ 450@300
]

{ #category : 'examples' }
SpSelectMultipleDialog class >> example [

	| presenter |
	presenter := self new.
	presenter
		title: 'Multiple select example';
		label: 'Select multiple classes';
		items: Smalltalk allClassesAndTraits;
		display: [ :each | each name ];
		displayIcon: [ :each | self iconNamed: each systemIconName ];
		onAccept: [ :dialog |
			dialog presenter inform: dialog presenter selectedItems asString ];
		openDialog
]

{ #category : 'examples' }
SpSelectMultipleDialog class >> exampleModal [

	| dialog selection |
	dialog := self new. 
	selection := dialog
		             title: 'Select multiple modal example';
		             label: 'Select multiple classes';
		             items: Smalltalk allClassesAndTraits;
		             display: [ :each | each name ];
		             displayIcon: [ :each |
			             self iconNamed: each systemIconName ];
		             openModal.

	selection ifNotNil: [ dialog inform: dialog selectedItems asString ]
]

{ #category : 'examples' }
SpSelectMultipleDialog class >> exampleMultiLineLabel [

	| presenter label |

	label := String streamContents: [ :s |
		s nextPutAll: 'Select multiple classes';
		  cr;
		  cr;
		  nextPutAll: 'Something else two lines bellow with a really long long long long text that will wrap'
		 ].
	
	presenter := self new.

	presenter
		title: 'Select multiple example';
		label: label;
		items: Smalltalk allClassesAndTraits;
		display: [ :each | each name ];
		displayIcon: [ :each | self iconNamed: each systemIconName ];
		onAccept: [ :dialog |
			dialog presenter inform: dialog presenter selectedItem asString ];
		openDialog
]

{ #category : 'accessing' }
SpSelectMultipleDialog >> columns [

	| columns checkboxColumn imageColumn textColumn |
	columns := OrderedCollection new.

	checkboxColumn := (SpCheckBoxTableColumn
		                   title: ' '
		                   evaluated: [ :item |
			                   selectedItems includes: item ])
		                  onActivation: [ :item | selectedItems add: item ];
		                  onDeactivation: [ :item |
			                  selectedItems remove: item ];
		                  width: 20;
		                  yourself.
	columns add: checkboxColumn.

	icon ifNotNil: [
		imageColumn := (SpImageTableColumn title: ' ' evaluated: icon)
			               width: 20;
			               yourself.
		columns add: imageColumn ].

	textColumn := SpStringTableColumn title: ' ' evaluated: display.
	columns add: textColumn.

	^ columns
]

{ #category : 'layout' }
SpSelectMultipleDialog >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: label height: self calculateLabelHeight;
		add: table1;
		yourself
]

{ #category : 'accessing' }
SpSelectMultipleDialog >> defaultTitle [

	^ 'Multiple request'
]

{ #category : 'api' }
SpSelectMultipleDialog >> display: aBlock [
	
	display := aBlock.
	self refreshTable
]

{ #category : 'api' }
SpSelectMultipleDialog >> displayIcon: aBlock [
	
	icon := aBlock.
	self refreshTable
]

{ #category : 'initialization' }
SpSelectMultipleDialog >> initialize [

	selectedItems := OrderedCollection new.
	super initialize
]

{ #category : 'initialization' }
SpSelectMultipleDialog >> initializePresenters [

	super initializePresenters.
	table1 := self newTable
		          beResizable;
		          yourself
]

{ #category : 'accessing' }
SpSelectMultipleDialog >> items [

	^ table1 items
]

{ #category : 'api' }
SpSelectMultipleDialog >> items: aCollection [

	table1 items: aCollection
]

{ #category : 'updating' }
SpSelectMultipleDialog >> refreshTable [

	table1 columns: self columns
]

{ #category : 'accessing' }
SpSelectMultipleDialog >> selectedItems [

	^ selectedItems
]
