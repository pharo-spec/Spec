"
I am the adapter used to bridge a ListPresenter and a PluggableListMorph
"
Class {
	#name : #MorphicListAdapter,
	#superclass : #AbstractMorphicAdapter,
	#category : #'Spec-MorphicAdapters-Base'
}

{ #category : #'widget API' }
MorphicListAdapter >> acceptDroppingMorph: draggedMorph event: event inMorph: source [
	| item index |
	
	index := source rowAtLocation: event position.
	item := self model getList at: index ifAbsent: [ nil ].
	
	^ self acceptDropBlock valueWithEnoughArguments: { draggedMorph model model . event. source model model. item. index }
]

{ #category : #'widget API' }
MorphicListAdapter >> autoDeselect [

	^ self model autoDeselect
]

{ #category : #'spec protocol' }
MorphicListAdapter >> autoDeselect: aBoolean [

	self widgetDo: [ :w | w autoDeselect: aBoolean ]
]

{ #category : #'widget API' }
MorphicListAdapter >> backgroundColorFor: anItem [
	^ self model backgroundColorFor: anItem
]

{ #category : #'widget API' }
MorphicListAdapter >> backgroundColorFor: anItem at: index [

	^ self model backgroundColorFor: anItem at: index
]

{ #category : #factory }
MorphicListAdapter >> buildWidget [
	widget := FTSpecPluggableIconListMorphAdaptor new
		model: self model;
		hideColumnHeaders;
		beResizable;
		autoDeselect: self autoDeselect;
		getListElementSelector: #listElementAt:;
		getListSizeSelector: #listSize;
		getIndexSelector: #getIndex;
		setIndexSelector: #setIndex:;
		getSelectionListSelector: #getSelectionStateFor:;
		setSelectionListSelector: #setSelectionStateFor:at:;
		resetListSelector: #resetListSelection;
		getMenuSelector: #menu:shifted:;
		setMultipleSelection: self multiSelection;
		doubleClickSelector: #doubleClick:;
		basicWrapSelector: #wrapItem:index:;
		backgroundColoringBlockOrSelector: #backgroundColorFor:at:;
		dragEnabled: self dragEnabled;
		dropEnabled: self dropEnabled;
		setBalloonText: self help;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		yourself.

	self itemFilterBlock
		ifNotNil: [ :block | 
			widget
				enableFilter: (FTSpecFilter block: block);
				explicitFunction ].

	^ widget
]

{ #category : #'widget API' }
MorphicListAdapter >> getIndex [

	^ self model getIndex
]

{ #category : #'widget API' }
MorphicListAdapter >> getSelectionStateFor: anIndex [

	^ self model getSelectionStateFor: anIndex
]

{ #category : #'widget API' }
MorphicListAdapter >> itemFilterBlock [
	^ self model itemFilterBlock
]

{ #category : #'widget API' }
MorphicListAdapter >> listElementAt: anIndex [

	^ self model listElementAt: anIndex
]

{ #category : #'widget API' }
MorphicListAdapter >> listElementAt: anIndex ifAbsent: aBlock [

	^ self model listElementAt: anIndex ifAbsent: aBlock
]

{ #category : #'widget API' }
MorphicListAdapter >> listSize [

	^ self model listSize
]

{ #category : #'widget API' }
MorphicListAdapter >> menu: aMenu shifted: aBoolean [

	^ (self model menu: aMenu shifted: aBoolean) 
		
]

{ #category : #'widget API' }
MorphicListAdapter >> multiSelection [

	^ self model multiSelection
]

{ #category : #'widget API' }
MorphicListAdapter >> resetListSelection [

	^ self model resetListSelection
]

{ #category : #'widget API' }
MorphicListAdapter >> setIndex: anIndex [

	^ self model setIndex: anIndex
]

{ #category : #'widget API' }
MorphicListAdapter >> setSelectionStateFor: anIndex at: aBoolean [

	^ self model setSelectionStateFor: anIndex at: aBoolean
]

{ #category : #'widget API' }
MorphicListAdapter >> wrapItem: anObject index: index [

	^ self model wrapItem: anObject index: index
]
