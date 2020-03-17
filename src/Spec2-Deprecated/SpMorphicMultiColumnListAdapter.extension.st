Extension { #name : #SpMorphicMultiColumnListAdapter }

{ #category : #'*Spec2-Deprecated' }
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

{ #category : #'*Spec2-Deprecated' }
SpMorphicMultiColumnListAdapter class >> isDeprecated [
	^ true
]
