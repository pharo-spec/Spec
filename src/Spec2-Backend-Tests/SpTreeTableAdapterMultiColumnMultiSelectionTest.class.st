Class {
	#name : 'SpTreeTableAdapterMultiColumnMultiSelectionTest',
	#superclass : 'SpTreeTableAdapterSingleColumnMultiSelectionTest',
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'initialization' }
SpTreeTableAdapterMultiColumnMultiSelectionTest >> initializeTestedInstance [ 

	presenter
		addColumn: (SpStringTableColumn title: 'Value' evaluated: #printString);
		addColumn: (SpImageTableColumn title: 'Icon' evaluated: [ :x | self iconNamed: #add ]);
		hideColumnHeaders;	
		beMultipleSelection;
		roots: #(1 2 3);
		children: [ :aNumber | { aNumber * 2. aNumber * 3. aNumber * 10 } ].

]
