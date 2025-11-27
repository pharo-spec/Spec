"
A foundation for the easy list family. 
The purpose of the *easy* family is to provide the users with a simple way to work with list, without the extra work that may cause the adoption of `SpListViewPresenter` and `SpColumnViewPresenter`.

## Why this hierarchy?
The first iteration of Spec had List and Table components which provided `display:`/`displayIcon:` access in the case of lists and a set of predefined column types for tables (`String`, `Checkbox`, `Image`...) . 
This is fine for many cases, but of course it has limits, that we try to overcome with this new versions: 

1. new list/table versions are polymorphic with the older, no change should be done to use them *as is*.
2. But older version was not flexible enough and was imposing very limited UI elements. Now we fix this by provinding `#rowPresenterClass:` accessor to define any arbitrary presenter as your row, in the case of lists, and the `SpEasyColumnViewColumn` (yes, the name is weird) that understands `#cellPresenterClass:` to set an arbitrary presenter to be used.
"
Class {
	#name : 'SpAbstractEasyListViewPresenter',
	#superclass : 'SpAbstractEasyPresenter',
	#classTraits : 'SpTSearchable classTrait',
	#category : 'Spec2-ListView-Easy',
	#package : 'Spec2-ListView',
	#tag : 'Easy'
}

{ #category : 'api - drag and drop' }
SpAbstractEasyListViewPresenter >> acceptDrop [

	^ contentView acceptDrop
]

{ #category : 'api - drag and drop' }
SpAbstractEasyListViewPresenter >> acceptDrop: aBoolean [

	contentView acceptDrop: aBoolean
]

{ #category : 'api' }
SpAbstractEasyListViewPresenter >> addScrollBarStyle: aStyle [

	contentView addScrollBarStyle: aStyle
]

{ #category : 'testing' }
SpAbstractEasyListViewPresenter >> dragEnabled [

	^ contentView dragEnabled
]

{ #category : 'api - drag and drop' }
SpAbstractEasyListViewPresenter >> dragEnabled: aBoolean [ 

	contentView dragEnabled: aBoolean
]

{ #category : 'testing' }
SpAbstractEasyListViewPresenter >> dropEnabled [

	^ contentView dropEnabled
]

{ #category : 'api - drag and drop' }
SpAbstractEasyListViewPresenter >> dropEnabled: aBoolean [

	contentView dropEnabled: aBoolean
]

{ #category : 'private' }
SpAbstractEasyListViewPresenter >> findFirst: aString [
	| items |

	items := contentView items.
	items isEmptyOrNil ifTrue: [ ^ 0 ].
	
	(contentView selection selectedIndex max: 1) to: items size do: [ :index | 
	 	(contentView 
			performSearch: (items at: index)
			matching: aString)
			ifTrue: [ ^ index ] ].
		
	^ 0
]

{ #category : 'api' }
SpAbstractEasyListViewPresenter >> items [

	^ contentView items
]

{ #category : 'api' }
SpAbstractEasyListViewPresenter >> items: aCollection [

	contentView items: aCollection
]

{ #category : 'api' }
SpAbstractEasyListViewPresenter >> listSize [

	^ contentView listSize
]

{ #category : 'api' }
SpAbstractEasyListViewPresenter >> model [

	^ contentView model
]

{ #category : 'api' }
SpAbstractEasyListViewPresenter >> model: aListModel [ 
	
	contentView model: aListModel
]

{ #category : 'api' }
SpAbstractEasyListViewPresenter >> removeScrollBarStyle: aStyle [

	^ contentView removeScrollBarStyle: aStyle
]

{ #category : 'initialization' }
SpAbstractEasyListViewPresenter >> resetListSelection [
	
	self selectIndex: 0
]

{ #category : 'api' }
SpAbstractEasyListViewPresenter >> scrollBarStyles [

	^ contentView scrollBarStyles
]

{ #category : 'api - selection' }
SpAbstractEasyListViewPresenter >> selectFirst [
	
	contentView selectFirst
]

{ #category : 'private' }
SpAbstractEasyListViewPresenter >> selectFirst: aString [
	| index |

	self isSearchEnabled ifFalse: [ ^ self ].

	index := self findFirst: aString.
	index = 0 ifTrue: [ ^ self ].
	
	contentView selectIndex: index scrollToSelection: true
]

{ #category : 'api - selection' }
SpAbstractEasyListViewPresenter >> selectIndex: anInteger [ 
	
	contentView selectIndex: anInteger
]

{ #category : 'api - selection' }
SpAbstractEasyListViewPresenter >> selectIndexes: anArray [
	
	contentView selectIndexes: anArray
]

{ #category : 'api - selection' }
SpAbstractEasyListViewPresenter >> selectItem: anObject [
	
	contentView selectItem: anObject
]

{ #category : 'api - selection' }
SpAbstractEasyListViewPresenter >> selectItem: anObject scrollToSelection: aBoolean [ 
	
	contentView 
		selectItem: anObject 
		scrollToSelection: aBoolean
]

{ #category : 'api - selection' }
SpAbstractEasyListViewPresenter >> selectItems: anArray [

	contentView selectItems: anArray
]

{ #category : 'api - selection' }
SpAbstractEasyListViewPresenter >> selectedIndex [

	^ contentView selectedIndex

]

{ #category : 'api - selection' }
SpAbstractEasyListViewPresenter >> selectedItem [
	
	^ contentView selectedItem
]

{ #category : 'api - selection' }
SpAbstractEasyListViewPresenter >> selectedItems [
	
	^ contentView selectedItems
]

{ #category : 'api - selection' }
SpAbstractEasyListViewPresenter >> selectedRowPresenter [

	^ contentView selectedRowPresenter
]

{ #category : 'api - selection' }
SpAbstractEasyListViewPresenter >> selection [
	
	^ contentView selection
]

{ #category : 'api' }
SpAbstractEasyListViewPresenter >> showColumnHeaders [
	
	self flag: #TODO
]

{ #category : 'api' }
SpAbstractEasyListViewPresenter >> sortingBlock: aBlock [ 

	self model sortingBlock: aBlock
]

{ #category : 'api - drag and drop' }
SpAbstractEasyListViewPresenter >> wantsDrop [

	^ contentView wantsDrop
]

{ #category : 'api - drag and drop' }
SpAbstractEasyListViewPresenter >> wantsDrop: aBlock [ 
	
	contentView wantsDrop: aBlock
]

{ #category : 'api - events' }
SpAbstractEasyListViewPresenter >> whenDragStartDo: aBlock [ 
	
	contentView whenDragStartDo: aBlock
]

{ #category : 'api - events' }
SpAbstractEasyListViewPresenter >> whenModelChangedDo: aBlock [

	contentView whenModelChangedDo: aBlock
]

{ #category : 'api' }
SpAbstractEasyListViewPresenter >> withScrollBars [

	contentView withScrollBars
]

{ #category : 'api' }
SpAbstractEasyListViewPresenter >> withoutScrollBars [

	contentView withoutScrollBars
]
