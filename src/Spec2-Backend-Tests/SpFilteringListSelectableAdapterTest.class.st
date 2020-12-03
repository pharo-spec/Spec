Class {
	#name : #SpFilteringListSelectableAdapterTest,
	#superclass : #SpAbstractAdapterTest,
	#instVars : [
		'listWithFilter'
	],
	#category : #'Spec2-Backend-Tests'
}

{ #category : #accessing }
SpFilteringListSelectableAdapterTest >> classToTest [

	^ SpFilteringSelectableListPresenter
]

{ #category : #tests }
SpFilteringListSelectableAdapterTest >> testClickOnRowTogglesSelection [

	presenter items: { 
		OrderedCollection.
		Array.
		SequenceableCollection.
		Set.
		Dictionary }.
	
	presenter listPresenter selectItem: Array.
	self openInstance.
	self assertEmpty: presenter selectedItems.
	presenter listPresenter adapter sendClickEventToRow: 2.
	self assert: (presenter selectedItems hasEqualElements: { Array })

]
