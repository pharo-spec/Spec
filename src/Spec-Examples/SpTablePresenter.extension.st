Extension { #name : #SpTablePresenter }

{ #category : #'*Spec-Examples' }
SpTablePresenter class >> example [
	<sampleInstance>
	
	^ self new
		addColumn: (ImageTableColumn title: 'Icon' evaluated: #systemIcon);
		addColumn: (StringTableColumn title: 'Name' evaluated: #name);
		items: Smalltalk allClasses;
		doubleClickAction: [ :aClass | self inform: 'Double click on: ', aClass name ];
		openWithSpec
]

{ #category : #'*Spec-Examples' }
SpTablePresenter class >> exampleEditableCell [

	self flag: #TODO
]

{ #category : #'*Spec-Examples' }
SpTablePresenter class >> exampleWithColumnHeaders [
	<sampleInstance>
	| example |
	example := self new.
	example
		addColumn: (StringTableColumn title: 'Number' evaluated: #yourself);
		addColumn: (StringTableColumn title: 'Hex' evaluated: #hex);
		showColumnHeaders;
		items: (1 to: 10) asArray;
		openWithSpec.
	^ example
]

{ #category : #'*Spec-Examples' }
SpTablePresenter class >> exampleWithoutColumnHeaders [
	<sampleInstance>
	| example |
	example := self new.
	example
		addColumn: (StringTableColumn title: 'Number' evaluated: #yourself);
		addColumn: (StringTableColumn title: 'Hex' evaluated: #hex);
		items: (1 to: 10) asArray;
		hideColumnHeaders;
		openWithSpec.
	^ example
]
