"
Description
--------------------

I show demos of tree tables
"
Class {
	#name : 'SpDemoTreeTablePresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'table1'
	],
	#category : 'Spec2-Examples-Demo-Tables',
	#package : 'Spec2-Examples',
	#tag : 'Demo-Tables'
}

{ #category : 'layout' }
SpDemoTreeTablePresenter >> defaultLayout [

	^ SpBoxLayout newTopToBottom
		add: table1;
		add: 'Double click to browse.' expand: false;
		yourself
]

{ #category : 'initialization' }
SpDemoTreeTablePresenter >> initializePresenters [

	table1 := self newTreeTable.
	table1
		addColumn: (SpCompositeTableColumn new
			title: 'Classes';
			addColumn: ((SpImageTableColumn 
				evaluated: [ :aClass | self iconNamed: aClass systemIconName ])
				width: 20;
				yourself);
			addColumn: (SpStringTableColumn evaluated: #name);
			yourself);
		addColumn: (SpStringTableColumn 
			title: 'Number of subclasses' 
			evaluated: [ :class | class subclasses size asString ]);
		addColumn: (SpStringTableColumn 
			title: 'Number of methods' 
			evaluated: [ :class | class methods size asString ]);
		roots: {Object};
		children: [ :aClass | aClass subclasses ];
		beResizable;
		actions: self menuActions;
		activateOnDoubleClick;
		whenActivatedDo: [ :selection | selection selectedItem browse ]
]

{ #category : 'accessing' }
SpDemoTreeTablePresenter >> menuActions [

	^ SpActionGroup new
		name: 'Context menu example';
		addGroupWith: [ :aGroup | aGroup
			addActionWith: [ :anItem | anItem
				name: 'Print in transcript';
				shortcut: $p actionModifier;
				description: 'Print the selected class on Transcript';
				action: [ table1 selectedItem traceCr ] ];
			addActionWith: [ :anItem | anItem
				name: 'Browse';
				iconName: #open;
				action: [ table1 selectedItem browse ] ];
			addGroupWith: [ :anItem | anItem
				name: 'Print infos';
				beDisplayedAsSubMenu;
				addActionWith: [ :item | item
					name: 'Print number of methods';
					action: [ table1 selectedItem methods size traceCr ] ];
				addActionWith: [ :item | item
					name: 'Print number of variables';
					action: [ table1 selectedItem instanceVariables size traceCr ] ] ] ];
		addGroupWith: [ :aGroup | aGroup
			addActionWith: [ :anItem | anItem
				name: 'Item showing only if item a odd number of letters';
				actionEnabled: [ table1 selectedItem printString size odd ];
				action: [ table1 selectedItem traceCr ] ];
			addActionWith: [ :anItem | anItem
				name: 'Disabled in second group';
				actionEnabled: [ false ];
				action: [ table1 selectedItem traceCr ] ];
			addActionWith: [ :anItem | anItem
				name: 'Disabled if class begins with A';
				actionEnabled: [ table1 selectedItem printString first ~= $A ];
				action: [ table1 selectedItem traceCr ] ] ];
		yourself
]
