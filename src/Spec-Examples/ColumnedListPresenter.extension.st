Extension { #name : #ColumnedListPresenter }

{ #category : #'*Spec-Examples' }
ColumnedListPresenter class >> example [
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
ColumnedListPresenter class >> exampleWithoutColumnHeaders [
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
