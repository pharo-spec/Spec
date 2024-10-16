Extension { #name : 'SpTreePresenter' }

{ #category : '*Spec2-Examples' }
SpTreePresenter class >> example [
	<sampleInstance>
	
	^ self new
		roots: { Object };
		children: [ :aClass | aClass subclasses ];
		displayIcon: [ :aClass | self iconNamed: aClass systemIconName ];
		display: [ :aClass | aClass name ];
		open
]

{ #category : '*Spec2-Examples' }
SpTreePresenter class >> exampleExpandPath [
	
	^ self new
		roots: { Object };
		children: [ :aClass | aClass subclasses ];
		displayIcon: [ :aClass | self iconNamed: aClass systemIconName ];
		display: [ :aClass | aClass name ];
		expandPath: #(1 1 3); "Object/Exception/Notification"
		open
]

{ #category : '*Spec2-Examples' }
SpTreePresenter class >> exampleExpandRoots [
	
	^ self new
		roots: { Object };
		children: [ :aClass | aClass subclasses ];
		displayIcon: [ :aClass | self iconNamed: aClass systemIconName ];
		display: [ :aClass | aClass name ];
		expandRoots;
		open
]

{ #category : '*Spec2-Examples' }
SpTreePresenter class >> exampleSelectPathByItems [
	
	^ self new
		roots: { Object };
		children: [ :aClass | aClass subclasses ];
		displayIcon: [ :aClass | self iconNamed: aClass systemIconName ];
		display: [ :aClass | aClass name ];
		open;
		selectPathByItems: self withAllSuperclasses reversed allButFirst scrollToSelection: true
]

{ #category : '*Spec2-Examples' }
SpTreePresenter class >> exampleWithContextMenu [
	<sampleInstance>
	| tree |

	self flag: #TODO. "This contextMenu was better, since it was updating before 
	execution... I need to be able to reproduce it."
	 	
	^ (tree := self new)
		roots: { Object };
		children: [ :aClass | aClass subclasses ];
		displayIcon: [ :aClass | self iconNamed: aClass systemIconName ];
		display: [ :aClass | aClass name ];
		addActionWith: [ :item | item name: tree selectedItem asString ];
		contextMenu: [
			SpMenuPresenter new 
				addGroup: [ :group | group 
					addItem: [ :item | item name: tree selectedItem asString ] ] ];
		open
]

{ #category : '*Spec2-Examples' }
SpTreePresenter class >> exampleWithDecoratedString [
	
	^ self new
		displayIcon: [ :aClass | self iconNamed: aClass systemIconName ];
		displayColor: [ :aClass | 
			(aClass name endsWith: 'Test')
				ifTrue: [ Color green ]
				ifFalse: [ Smalltalk ui theme textColor ] ];
		displayItalic: [ :aClass | aClass name includesSubstring: 'abstract' caseSensitive: false ];
		displayBold: [ :aClass | aClass hasSubclasses ];
		displayUnderline: [ :aClass | aClass numberOfMethods > 10 ];
		roots: { Object };
		children: [ :aClass | aClass subclasses ];
		open
]
