Extension { #name : #SpTablePresenter }

{ #category : #'*Spec2-Examples' }
SpTablePresenter class >> example [
	<sampleInstance>
	
	^ self new
		addColumn: (SpImageTableColumn 
			title: 'Icon' 
			evaluated: [ :aClass | self iconNamed: aClass systemIconName ]);
		addColumn: (SpStringTableColumn title: 'Name' evaluated: #name);
		items: Smalltalk allClasses;
		open
]

{ #category : #'*Spec2-Examples' }
SpTablePresenter class >> exampleDragAndDrop [
	| table1 table2 |

	(table1 := self new)
		items: #( 'abc' 'def' 'xyz' );
		addColumn: (SpStringTableColumn title: 'Drag' evaluated: #yourself);
		dragEnabled: true.
		
	(table2 := self new)
		dropEnabled: true;
		addColumn: (SpStringTableColumn title: 'Drop' evaluated: #yourself);
		wantsDrop: [ :transfer | transfer passenger allSatisfy: #isString ];
		acceptDrop: [ :transfer | table2 items: (table2 items, transfer passenger) ].
				
	SpPresenter new 
		layout: (SpBoxLayout newLeftToRight
			add: table1;
			add: table2;
			yourself);
		open
]

{ #category : #'*Spec2-Examples' }
SpTablePresenter class >> exampleFixedWidth [
	
	^ self new
		addColumn: ((SpImageTableColumn title: 'Icon' 
			evaluated: [ :aClass | self iconNamed: aClass systemIconName ]) 
			width: 30);
		addColumn: (SpStringTableColumn title: 'Name' evaluated: #name);
		items: Smalltalk allClasses;
		open
]

{ #category : #'*Spec2-Examples' }
SpTablePresenter class >> exampleFixedWidthResizable [
	"A fixed width cannot be changed even if the table is resizable"
	
	^ self new
		beResizable;
		addColumn: ((SpImageTableColumn title: 'Icon' 
			evaluated: [ :aClass | self iconNamed: aClass systemIconName ]) 
			width: 30);
		addColumn: (SpStringTableColumn title: 'Name' evaluated: #name);
		addColumn: (SpStringTableColumn title: 'Methods' evaluated: [ :each | each methods size ]);
		items: Smalltalk allClasses;
		open
]

{ #category : #'*Spec2-Examples' }
SpTablePresenter class >> exampleResizableColumns [
	
	^ self new
		beResizable;
		addColumn: (SpImageTableColumn 
			title: 'Icon' 
			evaluated: [ :aClass | self iconNamed: aClass systemIconName ]);
		addColumn: (SpStringTableColumn title: 'Name' evaluated: #name);
		items: Smalltalk allClasses;
		open
]

{ #category : #'*Spec2-Examples' }
SpTablePresenter class >> exampleSorting [
	"Example shows the two kinds of sorting, using a boolean compare, or a threeway sorting"
	| classNameCompare methodCountSorter |

	classNameCompare := [ :c1 :c2 | c1 name < c2 name ].
	methodCountSorter := [ :c1 :c2 | 
	                     c1 methodDictionary size threeWayCompareTo:
		                     c2 methodDictionary size ].

	self new
		addColumn: ((SpStringTableColumn title: 'Name' evaluated: #name) 
				 compareFunction: classNameCompare);
		addColumn: ((SpStringTableColumn
				  title: 'Methods' evaluated: [ :c | c methodDictionary size ]) 
				sortFunction: methodCountSorter);
		items: Smalltalk globals allClasses;
		open
]

{ #category : #'*Spec2-Examples' }
SpTablePresenter class >> exampleWithColumnHeaders [
	<sampleInstance>

	^ self new
		addColumn: (SpStringTableColumn title: 'Number' evaluated: #yourself);
		addColumn: (SpStringTableColumn title: 'Hex' evaluated: #hex);
		showColumnHeaders;
		items: (1 to: 10) asArray;
		open
]

{ #category : #'*Spec2-Examples' }
SpTablePresenter class >> exampleWithCompositeColumn [
	
	^ self new
		showColumnHeaders;
		addColumn: (SpStringTableColumn title: 'Package' evaluated: [ :aClass | aClass package packageName ]);
		addColumn: (SpCompositeTableColumn new
			title: 'Class';
			addColumn: (SpImageTableColumn new 
				evaluated: [ :aClass | self iconNamed: aClass systemIconName ];
				beNotExpandable;
				yourself);
			addColumn: (SpStringTableColumn evaluated: #name);
			yourself);
		items: Smalltalk allClasses;
		open
]

{ #category : #'*Spec2-Examples' }
SpTablePresenter class >> exampleWithDecoratedString [
	
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
		items: Smalltalk allClasses;
		open
]

{ #category : #'*Spec2-Examples' }
SpTablePresenter class >> exampleWithIndexTableColumn [
	"Shows the classes adding a column with the row number as column (because when you have a
	 model, you don't know its position (row index) in the table, and sometimes you want to
	 add a hint of where you are placed"

	^ self new
		addColumn: (SpIndexTableColumn title: 'Row Number');
		addColumn: (SpCompositeTableColumn new
			title: 'Class';
			sortFunction: #name ascending;
			addColumn: (SpImageTableColumn new
				evaluated: [ :aClass | self iconNamed: aClass systemIconName ];
				beNotExpandable);
			addColumn: (SpStringTableColumn evaluated: #name);
			yourself);
		items: Smalltalk allClasses;
		open
]

{ #category : #'*Spec2-Examples' }
SpTablePresenter class >> exampleWithSortableColumnHeaders [

	^ self new
		showColumnHeaders;
		addColumn: (SpStringTableColumn title: 'Number' evaluated: #yourself) beSortable;
		addColumn: (SpStringTableColumn title: 'Hex' evaluated: #hex) beSortable;
		items: (1 to: 16) asArray;
		open
]

{ #category : #'*Spec2-Examples' }
SpTablePresenter class >> exampleWithoutColumnHeaders [
	<sampleInstance>
	| example |
	example := self new.
	example
		addColumn: (SpStringTableColumn title: 'Number' evaluated: #yourself);
		addColumn: (SpStringTableColumn title: 'Hex' evaluated: #hex);
		items: (1 to: 10) asArray;
		hideColumnHeaders;
		open.
	^ example
]

{ #category : #'*Spec2-Examples' }
SpTablePresenter class >> exampleWriteableTable [
	"The selector names are NOT stored, but serves merely to have something one can edit"
	| items |
	
	items := String methods.
	^ self new
		addColumn: (SpStringTableColumn new 
			title: 'Editable selector name';
			evaluated: [ :m | m selector ];
			displayBold: [ :m | m selector isKeyword ];
			beEditable ;
			onAcceptEdition: [ :m :t | Transcript nextPutAll: t;cr;endEntry ];
			yourself);
		addColumn: (SpStringTableColumn title: 'Size' evaluated: #size) beSortable;
		showColumnHeaders;
		items: items;
		open
]
