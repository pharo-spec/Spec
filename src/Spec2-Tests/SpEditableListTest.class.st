Class {
	#name : #SpEditableListTest,
	#superclass : #SpSmokeTest,
	#category : #'Spec2-Tests-Core-Widgets'
}

{ #category : #running }
SpEditableListTest >> classToTest [
	^ SpEditableList
]

{ #category : #tests }
SpEditableListTest >> testCanAddNewItem [
	presenter 
		items: #(1 2 3);
		addItemBlock: [ 4 ].
		
	presenter addButton click.
	
	self 
		assertCollection: presenter displayedItems
		hasSameElements: #(1 2 3 4)
]

{ #category : #tests }
SpEditableListTest >> testCanRemoveSelectedItem [
	presenter 
		items: #(1 2 3);
		selectItem: 2.
	
	presenter removeButton click.
	
	self 
		assertCollection: presenter displayedItems
		hasSameElements: #(1 3)
]

{ #category : #tests }
SpEditableListTest >> testMoveElementAtTo [
	presenter items: {'AAA' . 'BBB' . 'CCC'}.
	presenter moveElementAt: 1 to: 3.
	self
		assert: presenter displayedItems asArray
		equals: {'BBB' . 'CCC' . 'AAA'}
]
