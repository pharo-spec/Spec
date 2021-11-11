Extension { #name : #SpTreeTablePresenter }

{ #category : #'*Spec2-Examples' }
SpTreeTablePresenter class >> example [

	^ self new
		addColumn: (SpCompositeTableColumn new
			title: 'Classes';
			addColumn: ((SpImageTableColumn evaluated: #systemIcon) width: 20);
			addColumn: (SpStringTableColumn evaluated: #name);
			yourself);
		roots: { Object };
		children: [ :aClass | aClass subclasses ];
		openWithSpec
]

{ #category : #'*Spec2-Examples' }
SpTreeTablePresenter class >> exampleExpandPath [

	^ self new
		addColumn: (SpCompositeTableColumn new
			title: 'Classes';
			addColumn: ((SpImageTableColumn evaluated: #systemIcon) width: 20);
			addColumn: (SpStringTableColumn evaluated: #name);
			yourself);
		roots: { Object };
		children: [ :aClass | aClass subclasses ];
		expandPath: #(1 1 3); "Object/Exception/Notification"
		openWithSpec
]

{ #category : #'*Spec2-Examples' }
SpTreeTablePresenter class >> exampleExpandRoots [

	^ self new
		addColumn: (SpCompositeTableColumn new
			title: 'Classes';
			addColumn: ((SpImageTableColumn evaluated: #systemIcon) width: 20);
			addColumn: (SpStringTableColumn evaluated: #name);
			yourself);
		roots: { Object };
		children: [ :aClass | aClass subclasses ];
		expandRoots;
		openWithSpec
]

{ #category : #'*Spec2-Examples' }
SpTreeTablePresenter class >> exampleResizableColumns [

	^ self  new
		beResizable;
		addColumn: (SpCompositeTableColumn new
			title: 'Classes';
			addColumn: ((SpImageTableColumn evaluated: [:c| c systemIcon]) );
			addColumn: (SpStringTableColumn evaluated: #name);
			yourself);
		addColumn: (SpStringTableColumn new
			title: 'Methods';
			evaluated: [:class | class methodDictionary size asString]);
		roots: { Object };
		children: [ :aClass | aClass subclasses ];
		openWithSpec
]

{ #category : #'*Spec2-Examples' }
SpTreeTablePresenter class >> exampleWithDecoratedString [
	
	^ self new
		addColumn: (SpImageTableColumn title: 'Icon' evaluated: [ :aClass | aClass systemIcon ]);
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
		openWithSpec
]

{ #category : #'*Spec2-Examples' }
SpTreeTablePresenter class >> exampleWithTwoColumns [ 

	^ self  new
		addColumn: (SpCompositeTableColumn new
			title: 'Classes';
			addColumn: ((SpImageTableColumn evaluated: [:c| c systemIcon]) );
			addColumn: (SpStringTableColumn evaluated: #name);
			yourself);
		addColumn: (SpStringTableColumn new
			title: 'Methods';
			evaluated: [:class | class methodDictionary size asString]);
		roots: { Object };
		children: [ :aClass | aClass subclasses ];
		openWithSpec
]
