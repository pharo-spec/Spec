"
I am the adapter used to bridge a MultiColumnListPresenter and a PluggableMultiColumnListMorph
"
Class {
	#name : 'SpMorphicMultiColumnListAdapter',
	#superclass : 'SpMorphicListAdapter',
	#category : 'Spec2-Deprecated-Adapters',
	#package : 'Spec2-Deprecated',
	#tag : 'Adapters'
}

{ #category : '*Spec2-Deprecated' }
SpMorphicMultiColumnListAdapter class >> isDeprecated [
	^ true
]

{ #category : '*Spec2-Deprecated' }
SpMorphicMultiColumnListAdapter class >> isDeprecated [
	^ true
]

{ #category : '*Spec2-Deprecated' }
SpMorphicMultiColumnListAdapter >> buildWidget [
	^ PluggableMultiColumnListMorph new
		wrapSelector: #wrapItem:index:;
		model: self;
		getListSizeSelector: #listSize;
		getIndexSelector: #getIndex;
		setIndexSelector: #setIndex:;
		getListElementSelector: #listElementAt:;
		resetListSelector: #resetListSelection;
		getMenuSelector: #menu:shifted:;
		dragEnabled: self dragEnabled;
		dropEnabled: self dropEnabled;
		setMultipleSelection: self multiSelection;
		setBalloonText: self help;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		yourself
]

{ #category : '*Spec2-Deprecated' }
SpMorphicMultiColumnListAdapter >> buildWidget [
	^ PluggableMultiColumnListMorph new
		wrapSelector: #wrapItem:index:;
		model: self;
		getListSizeSelector: #listSize;
		getIndexSelector: #getIndex;
		setIndexSelector: #setIndex:;
		getListElementSelector: #listElementAt:;
		resetListSelector: #resetListSelection;
		getMenuSelector: #menu:shifted:;
		dragEnabled: self dragEnabled;
		dropEnabled: self dropEnabled;
		setMultipleSelection: self multiSelection;
		setBalloonText: self help;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		yourself
]
