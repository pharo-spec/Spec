"
I am a simple example showing how to use a menu model to have a menu toolbar.

self example
"
Class {
	#name : 'SpApplicationWithToolbar',
	#superclass : 'SpPresenter',
	#instVars : [
		'menu',
		'text'
	],
	#category : 'Spec2-Examples-Standalone',
	#package : 'Spec2-Examples',
	#tag : 'Standalone'
}

{ #category : 'examples' }
SpApplicationWithToolbar class >> example [

	<sampleInstance>
	^ self new open
]

{ #category : 'initialization' }
SpApplicationWithToolbar >> addItemTo: aGroup [
	aGroup
		addItem: [ :item | 
			item
				name: 'Dynamic';
				icon: (self iconNamed: #delete);
				action: [ aGroup menuItems remove: item.
					self needRebuild: false.
					self build ] ].
	self needRebuild: false.
	self build
]

{ #category : 'layout' }
SpApplicationWithToolbar >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: menu expand: false;
		add: text;
		yourself
]

{ #category : 'initialization' }
SpApplicationWithToolbar >> initializePresenters [
	menu := self newMenuBar
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: 'File';
						icon: (self iconNamed: #open);
						subMenu: self subMenu ].
			group
				addItem: [ :item | 
					item
						name: '';
						description: 'Open file';
						icon: (self iconNamed: #open);
						action: [ self inform: 'Open File' ] ].
			group
				addItem: [ :item | 
					item
						name: '';
						description: 'Save File';
						icon: (self iconNamed: #smallSave);
						action: [ self inform: 'Save File' ] ].
			group
				addItem: [ :item | 
					item
						name: '';
						description: 'Print file';
						icon: (self iconNamed: #smallPrint);
						action: [ self inform: 'Print file' ] ] ];
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: '';
						description: 'Undo';
						icon: (self iconNamed: #smallUndo);
						action: [ self inform: 'Undo' ] ].
			group
				addItem: [ :item | 
					item
						name: '';
						description: 'Redo';
						icon: (self iconNamed: #smallRedo);
						action: [ self inform: 'Redo' ] ] ];
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: '';
						description: 'Add menu item';
						icon: (self iconNamed: #add);
						action: [ self addItemTo: group ] ] ].
	menu addKeyBindingsTo: self.
	text := self newText.
	self focusOrder add: text
]

{ #category : 'accessing' }
SpApplicationWithToolbar >> menu [
	^ menu
]

{ #category : 'initialization' }
SpApplicationWithToolbar >> subMenu [
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Open';
				icon: (self iconNamed: #open);
				shortcut: $o meta;
				action: [ self inform: 'Open' ] ];
		addItem: [ :item | 
			item
				name: 'Save';
				icon: (self iconNamed: #smallSave);
				shortcut: $s meta;
				action: [ self inform: 'Save' ] ];
		addItem: [ :item | 
			item
				name: 'Print';
				shortcut: $p meta;
				icon: (self iconNamed: #smallPrint);
				action: [ self inform: 'Print' ] ];
		addItem: [ :item | 
			item
				name: 'Kill';
				shortcut: $k meta;
				icon: (self iconNamed: #smallCancel);
				action: [ self inform: 'Kill' ] ];
		yourself
]

{ #category : 'accessing' }
SpApplicationWithToolbar >> text [
	^ text
]

{ #category : 'api' }
SpApplicationWithToolbar >> title [

	^ 'Text editor'
]
