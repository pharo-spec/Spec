Class {
	#name : #AbstractListPresenter,
	#superclass : #AbstractWidgetPresenter,
	#instVars : [
		'selectionMode',
		'multiSelectionHolder',
		'selectionHolder'
	],
	#category : #'Spec-Core-Widgets-Table'
}

{ #category : #selection }
AbstractListPresenter >> selectIndex: anInteger [ 
	
	self selectionMode selectIndex: anInteger on: self
]

{ #category : #selection }
AbstractListPresenter >> selectItem: anItem [ 
	
	self selectionMode selectItem: anItem on: self
]

{ #category : #api }
AbstractListPresenter >> selectedIndex [
	"Return the index of the selected item
	In the case of a multiple selection list, it returns the last selected item"
	
	self
		deprecated: 'Use the #selection object instead. This method assumes single selection'
		transformWith: '`@receiver selectedIndex'
						-> '`@receiver selection selectedIndex'.
	
	^  self selection selectedIndex
]

{ #category : #api }
AbstractListPresenter >> selectedIndex: anIndex [

	"Set the index of the item you want to be selected"
	| idx selection |
	self
		deprecated: 'Use #selectIndex: instead'
		transformWith: '`@receiver selectedIndex: `@arg'
						-> '`@receiver selectIndex: `@arg'.
	
	self selectIndex: anIndex
]

{ #category : #api }
AbstractListPresenter >> selectedIndexes [
	"<api: #inspect>"
	"Return the indexes of selected items on the case of a multiple selection list"
	
	^ multiSelectionHolder indexes
]

{ #category : #api }
AbstractListPresenter >> selectedItem [
	"Return the selected item.
	In the case of a multiple selection list, it returns the last selected item"
	
	self
		deprecated: 'Use the #selection object instead. This method assumes single selection'
		transformWith: '`@receiver selectedItem'
						-> '`@receiver selection selectedItem'.
	
	^ self selection selectedItem
]

{ #category : #api }
AbstractListPresenter >> selectedItem: anItem [
	"Set the item you want to be selected"
	| index selectedItem |
	
	self
		deprecated: 'Use #selectItem: instead'
		transformWith: '`@receiver selectedItem: `@arg'
						-> '`@receiver selectItem: `@arg'.

	self selectItem: anItem
]

{ #category : #api }
AbstractListPresenter >> selectedItems [
	"<api: #inspect>"
	"Return all the selected items in the case of a multiple selection list"

	^ self selectedItemsAtIndexes: self selectedIndexes
]

{ #category : #private }
AbstractListPresenter >> selectedItemsAtIndexes: aCollectionOfIndex [
	^ aCollectionOfIndex collect: [ :anIndex | self listElementAt: anIndex ]
]

{ #category : #api }
AbstractListPresenter >> selectedItemsSorted [
	"return all the selected items sorted by their index"

	^ self selectedItemsAtIndexes: self selectedIndexes sort
]

{ #category : #private }
AbstractListPresenter >> setIndex: anIndex [
	"Set the index of the selected item when you click on an item"

	(self allowToSelect and: [ self okToChange ]) ifFalse: [ ^ self ].
	selectionHolder index value: anIndex.
	selectionHolder selection value: (self listElementAt: anIndex)
]

{ #category : #private }
AbstractListPresenter >> setIndexes: aCollectionOfIndex [
	"Set the indexexs of the selected items in case of multiple selection"

	(self allowToSelect and: [ self okToChange and: [ self multiSelection ] ]) ifFalse: [ ^ self ].
	multiSelectionHolder indexes value: aCollectionOfIndex.
	multiSelectionHolder selections value: (self selectedItemsAtIndexes: aCollectionOfIndex)
]

{ #category : #api }
AbstractListPresenter >> setSelectedIndex: anIndex [
	self
		deprecated: 'Use #selectedIndex: instead'
		transformWith:
			'`@receiver setSelectedIndex: `@argument'
				-> '`@receiver selectedIndex: `@argument'.
	^ self selectIndex: anIndex
]

{ #category : #api }
AbstractListPresenter >> setSelectedItem: anIndex [
	self
		deprecated: 'Use #selectedItem: instead'
		transformWith:
			'`@receiver setSelectedItem: `@argument'
				-> '`@receiver selectedItem:`@argument'.
	^ self selectItem: anIndex
]
