"
A presenter to show a dynamic list of presenters. 
When you do not have a list of elements that can be presented as a single list or table, it is possible to display a collection of presenters as a list using this component.

**IMPORTANT:** while this list type in general has no sense now with the new `SpEasyListViewPresenter`/`SpEasyColumnViewPresenter` components that can display arbitrary presenters, it may still has a small use case for where each presenter is really different.  
Please verify this is really needed before using it.
"
Class {
	#name : 'SpEasyComponentListPresenter',
	#superclass : 'SpAbstractEasyListViewPresenter',
	#category : 'Spec2-ListView-Easy',
	#package : 'Spec2-ListView',
	#tag : 'Easy'
}

{ #category : 'examples' }
SpEasyComponentListPresenter class >> example [
	| list |
	
	list := { 
		SpLabelPresenter new label: 'Test 1'; yourself.
		SpImagePresenter new image: (self iconNamed: #smallOk); yourself.
		SpButtonPresenter new label: 'A button'; yourself }.

	^ self new 
		presenters: list;
		open
]

{ #category : 'api' }
SpEasyComponentListPresenter >> contextMenu: aBlock [
 
	self flag: #TODO. "Ignored, as this should be deprecated"
	
]

{ #category : 'initialization' }
SpEasyComponentListPresenter >> initializePresenters [

	super initializePresenters.

	contentView := self newListView
		setup: [ :aPresenter | 
			aPresenter newPresenter
				layout: SpBoxLayout newVertical;
				yourself ];
		bind: [ :aPresenter :childObject | 
			aPresenter layout
				removeAll;
				add: childObject;
				yourself ];
		yourself
]

{ #category : 'api' }
SpEasyComponentListPresenter >> presenters [

	^ self items
]

{ #category : 'api' }
SpEasyComponentListPresenter >> presenters: aCollectionOfPresenters [

	self items: aCollectionOfPresenters
]

{ #category : 'api' }
SpEasyComponentListPresenter >> updateItemsKeepingSelection: aCollection [
	
	contentView updateItemsKeepingSelection: aCollection
]

{ #category : 'api - events' }
SpEasyComponentListPresenter >> whenPresentersChangedDo: aBlock [
	"Inform when the presenter list changed (See `SpComponentListPresenter>>#presenters:`.
	 `aBlock` receive 3 optional arguments: 
	 - new value 
	 - old value 
	 - announcement triggered"
	
	contentView whenModelChangedDo: aBlock
]
