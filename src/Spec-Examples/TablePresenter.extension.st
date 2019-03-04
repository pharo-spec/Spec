Extension { #name : #TablePresenter }

{ #category : #'*Spec-Examples' }
TablePresenter class >> example [
	<sampleInstance>
	
	^ self new
		addColumn: (ImageTableColumn title: 'Icon' evaluated: #systemIcon);
		addColumn: (StringTableColumn title: 'Name' evaluated: #name);
		items: Smalltalk allClasses;
		doubleClickAction: [ :aClass | self inform: 'Double click on: ', aClass name ];
		openWithSpec
]

{ #category : #'*Spec-Examples' }
TablePresenter class >> exampleEditableCell [

	self flag: #TODO
]
