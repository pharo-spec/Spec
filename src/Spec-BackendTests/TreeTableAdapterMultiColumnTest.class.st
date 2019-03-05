Class {
	#name : #TreeTableAdapterMultiColumnTest,
	#superclass : #TreeTableAdapterSingleColumnTest,
	#category : #'Spec-BackendTests'
}

{ #category : #running }
TreeTableAdapterMultiColumnTest >> initializeTestedInstance [ 

	presenter
		addColumn: (StringTableColumn title: 'Value' evaluated: #printString);
		addColumn: (ImageTableColumn title: 'Icon' evaluated: [ :x | self iconNamed: #add ]);
		hideColumnHeaders;
		roots: #(1 2 3);
		children: [ :aNumber | { aNumber * 2. aNumber * 3. aNumber * 10 } ].

]
