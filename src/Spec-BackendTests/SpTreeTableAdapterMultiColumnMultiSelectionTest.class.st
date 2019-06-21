Class {
	#name : #SpTreeTableAdapterMultiColumnMultiSelectionTest,
	#superclass : #SpTreeTableAdapterSingleColumnMultiSelectionTest,
	#category : #'Spec-BackendTests'
}

{ #category : #running }
SpTreeTableAdapterMultiColumnMultiSelectionTest >> initializeTestedInstance [ 

	presenter
		addColumn: (StringTableColumn title: 'Value' evaluated: #printString);
		addColumn: (ImageTableColumn title: 'Icon' evaluated: [ :x | self iconNamed: #add ]);
		hideColumnHeaders;	
		beMultipleSelection;
		roots: #(1 2 3);
		children: [ :aNumber | { aNumber * 2. aNumber * 3. aNumber * 10 } ].

]
