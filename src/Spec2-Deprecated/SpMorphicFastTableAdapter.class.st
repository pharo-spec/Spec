"
I am the adapter used to bridge an FastTablePresenter and a FTPluggableIconListMorphAdaptor
"
Class {
	#name : #SpMorphicFastTableAdapter,
	#superclass : #SpMorphicListAdapter,
	#category : #'Spec2-Deprecated-Adapters'
}

{ #category : #'*Spec2-Deprecated' }
SpMorphicFastTableAdapter class >> isDeprecated [
	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicFastTableAdapter >> buildWidget [
	^ FTPluggableIconListMorphAdaptor new
		model: self model;
		hideColumnHeaders;
		beResizable;
		columns: self model columns;
		getListSizeSelector: #listSize;
		getListElementSelector: #listElementAt:;
		getIndexSelector: #getIndex;
		setIndexSelector: #setIndex:;
		getIconSelector: #getIconFor:;
		resetListSelector: #resetListSelection;
		getMenuSelector: #menu:shifted:;
		setMultipleSelection: self model selection isMultipleSelection;
		doubleClickSelector: #doubleClick:;
		basicWrapSelector: #wrapItem:;
		dragEnabled: self dragEnabled;
		dropEnabled: self dropEnabled;
		setBalloonText: self help;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		selectIndex: 1;
		enableFilter: FTSubstringFilter;
		explicitFunction;
		yourself
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicFastTableAdapter >> doubleClick: event [

	^ self model doubleClick: event
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicFastTableAdapter >> getIconFor: anItem [

	^ self model getIconFor: anItem
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicFastTableAdapter >> wrapItem: anObject [

	^ self model wrapItem: anObject
]
