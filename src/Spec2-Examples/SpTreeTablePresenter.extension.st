Extension { #name : 'SpTreeTablePresenter' }

{ #category : '*Spec2-Examples' }
SpTreeTablePresenter class >> example [

	^ self new
		addColumn: (SpCompositeTableColumn new
			title: 'Classes';
			addColumn: (SpImageTableColumn new 
				evaluated: [ :aClass | self iconNamed: aClass systemIconName]; 
				width: 20);
			addColumn: (SpStringTableColumn evaluated: #name);
			yourself);
		roots: { Object };
		children: [ :aClass | aClass subclasses ];
		open
]

{ #category : '*Spec2-Examples' }
SpTreeTablePresenter class >> exampleExpandPath [

	^ self new
		addColumn: (SpCompositeTableColumn new
			title: 'Classes';
			addColumn: (SpImageTableColumn new
				evaluated: [ :aClass | self iconNamed: aClass systemIconName ]; 
				width: 20);
			addColumn: (SpStringTableColumn evaluated: #name);
			yourself);
		roots: { Object };
		children: [ :aClass | aClass subclasses ];
		expandPath: #(1 1 3); "Object/Exception/Notification"
		open
]

{ #category : '*Spec2-Examples' }
SpTreeTablePresenter class >> exampleExpandRoots [

	^ self new
		addColumn: (SpCompositeTableColumn new
			title: 'Classes';
			addColumn: (SpImageTableColumn new
				evaluated: [ :aClass | self iconNamed: aClass systemIconName ]; 
				width: 20);
			addColumn: (SpStringTableColumn evaluated: #name);
			yourself);
		roots: { Object };
		children: [ :aClass | aClass subclasses ];
		expandRoots;
		open
]

{ #category : '*Spec2-Examples' }
SpTreeTablePresenter class >> exampleResizableColumns [

	^ self  new
		beResizable;
		addColumn: (SpCompositeTableColumn new
			title: 'Classes';
			addColumn: ((SpImageTableColumn evaluated: [ :aClass | self iconNamed: aClass systemIconName ]) );
			addColumn: (SpStringTableColumn evaluated: #name);
			yourself);
		addColumn: (SpStringTableColumn new
			title: 'Methods';
			evaluated: [:class | class methodDictionary size asString]);
		roots: { Object };
		children: [ :aClass | aClass subclasses ];
		open
]

{ #category : '*Spec2-Examples' }
SpTreeTablePresenter class >> exampleResizableColumnsFixedWidth [

	^ self  new
		beResizable;
		addColumn: (SpCompositeTableColumn new
			title: 'Classes';
			addColumn: ((SpImageTableColumn evaluated: [ :aClass | self iconNamed: aClass systemIconName ]) );
			addColumn: (SpStringTableColumn evaluated: #name);
			width: 150;
			beExpandable;
			yourself);
		addColumn: (SpStringTableColumn new
			title: 'Methods';
			evaluated: [:class | class methodDictionary size asString]);
		roots: { Object };
		children: [ :aClass | aClass subclasses ];
		open
]

{ #category : '*Spec2-Examples' }
SpTreeTablePresenter class >> exampleWithDecoratedString [
	
	^ self new
		addColumn: (SpImageTableColumn 
			title: 'Icon' 
			evaluated: [ :aClass | self iconNamed: aClass systemIconName ]);
		addColumn: (SpStringTableColumn new 
			title: 'Name'; 
			evaluated: [ :aClass | aClass name ];
			displayColor: [ :aClass | 
				(aClass name endsWith: 'Test')
					ifTrue: [ Color green ]
					ifFalse: [ Smalltalk ui theme textColor ] ];
			displayItalic: [ :aClass | aClass name includesSubstring: 'abstract' caseSensitive: false ];
			displayBold: [ :aClass | aClass hasSubclasses ];
			displayUnderline: [ :aClass | aClass numberOfMethods > 10 ];
			yourself);
		roots: { Object };
		children: [ :aClass | aClass subclasses ];
		open
]

{ #category : '*Spec2-Examples' }
SpTreeTablePresenter class >> exampleWithTwoColumns [ 

	^ self  new
		addColumn: (SpCompositeTableColumn new
			title: 'Classes';
			addColumn: ((SpImageTableColumn evaluated: [ :aClass | self iconNamed: aClass systemIconName ]) );
			addColumn: (SpStringTableColumn evaluated: #name);
			yourself);
		addColumn: (SpStringTableColumn new
			title: 'Methods';
			evaluated: [:class | class methodDictionary size asString]);
		roots: { Object };
		children: [ :aClass | aClass subclasses ];
		open
]
