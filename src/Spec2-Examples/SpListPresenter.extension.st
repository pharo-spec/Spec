Extension { #name : 'SpListPresenter' }

{ #category : '*Spec2-Examples' }
SpListPresenter class >> example [
	<sampleInstance>
	^ self new
		items: self environment allClasses;
		open;
		yourself
]

{ #category : '*Spec2-Examples' }
SpListPresenter class >> exampleDragAndDrop [
	| list1 list2 |

	(list1 := self new)
		items: #( 'abc' 'def' 'xyz' );
		dragEnabled: true.
		
	(list2 := self new)
		dropEnabled: true;
		wantsDrop: [ :transfer | transfer passenger allSatisfy: #isString ];
		acceptDrop: [ :transfer | list2 items: (list2 items, transfer passenger) ].
				
	SpPresenter new 
		layout: (SpBoxLayout newLeftToRight
			add: list1;
			add: list2;
			yourself);
		open
]

{ #category : '*Spec2-Examples' }
SpListPresenter class >> exampleMultipleSelection [
	<sampleInstance>
	^ self new
		items: self environment allClasses;
		beMultipleSelection;
		open;
		yourself
]

{ #category : '*Spec2-Examples' }
SpListPresenter class >> exampleWithDecoratedString [
	
	^ self new
		items: self environment allClasses;
		displayIcon: [ :aClass | self iconNamed: aClass systemIconName  ];
		displayColor: [ :aClass | 
			(aClass name endsWith: 'Test')
				ifTrue: [ Color green ]
				ifFalse: [ Smalltalk ui theme textColor ] ];
		displayItalic: [ :aClass | aClass name includesSubstring: 'abstract' caseSensitive: false ];
		displayBold: [ :aClass | aClass hasSubclasses ];
		displayUnderline: [ :aClass | aClass numberOfMethods > 10 ];
		open
]

{ #category : '*Spec2-Examples' }
SpListPresenter class >> exampleWithHeaderTitle [
	<sampleInstance>
	^ self new
		items: self environment allClasses;
		headerTitle: 'Title';
		open;
		yourself
]

{ #category : '*Spec2-Examples' }
SpListPresenter class >> exampleWithIcons [
	<sampleInstance>
	^ self new
		displayIcon: [ :e | self iconNamed: #forwardIcon ];
		items: (1 to: 10) asArray;
		open;
		yourself
]

{ #category : #'*Spec2-Examples' }
SpListPresenter class >> exampleWithIconsAndSelectedItem [

	^ self new
		displayIcon: [ :aClass | self iconNamed: aClass systemIconName ];
		items: Smalltalk allClasses;
		selectItem: Object scrollToSelection: true;
		open;
		yourself
]
