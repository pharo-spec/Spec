Extension { #name : #SpDropListPresenter }

{ #category : #'*Spec2-Deprecated' }
SpDropListPresenter >> displayBlock [
	
	self
		deprecated: 'Please use #display instead'
		transformWith: '`@receiver displayBlock' 
						-> '`@receiver display'.
	
	^ displayBlock
]

{ #category : #'*Spec2-Deprecated' }
SpDropListPresenter >> displayBlock: aBlock [
	
	self
		deprecated: 'Please use #display: instead'
		transformWith: '`@receiver displayBlock: `@arg' 
						-> '`@receiver display: `@arg'.
	
	displayBlock := aBlock 

]

{ #category : #'*Spec2-Deprecated' }
SpDropListPresenter >> iconHolder [
	
	self 
		deprecated: 'Use iconBlock instead' 
		transformWith: '`@receiver iconHolder' -> '`@receiver iconBlock'.

	^ self iconBlock
]

{ #category : #'*Spec2-Deprecated' }
SpDropListPresenter >> iconHolder: aBlock [	
	self 
		deprecated: 'Use iconBlock: instead' 
		transformWith: '`@receiver iconHolder: `@statements1' -> '`@receiver iconBlock: `@statements1'.
	
	self iconBlock: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpDropListPresenter >> selectedIndex: anIndex [

	"Set the index of the item you want to be selected"
	self
		deprecated: 'Use #selectIndex: instead'
		transformWith: '`@receiver selectedIndex: `@arg'
						-> '`@receiver selectIndex: `@arg'.
	
	self selectIndex: anIndex
]

{ #category : #'*Spec2-Deprecated' }
SpDropListPresenter >> selectedItem: anItem [
	"Set the item you want to be selected"

	self
		deprecated: 'Use #selectItem: instead'
		transformWith: '`@receiver selectedItem: `@arg'
						-> '`@receiver selectItem: `@arg'.

	self selectItem: anItem
]

{ #category : #'*Spec2-Deprecated' }
SpDropListPresenter >> setSelectedIndex: anIndex [
	self
		deprecated: 'Use #selectedIndex: instead'
		transformWith:
			'`@receiver setSelectedIndex: `@argument'
				-> '`@receiver selectedIndex:`@argument'.
	^ self selectedIndex: anIndex	

]

{ #category : #'*Spec2-Deprecated' }
SpDropListPresenter >> setSelectedItem: anItem [
	self
		deprecated: 'Use #selectedItem: instead'
		transformWith:
			'`@receiver setSelectedItem: `@argument'
				-> '`@receiver selectedItem:`@argument'.
	^ self selectedItem: anItem	

]

{ #category : #'*Spec2-Deprecated' }
SpDropListPresenter >> whenSelectedItemChanged: aBlock [
	self deprecated: 'Use #whenSelectedItemChangedDo: instead.' transformWith: '`@receiver whenSelectedItemChanged: `@statements' -> '`@receiver whenSelectedItemChangedDo: `@statements'.
	self whenSelectedItemChangedDo: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpDropListPresenter >> whenSelectionChanged: aBlock [
	self deprecated: 'Use #whenSelectionChangedDo: instead.' transformWith: '`@receiver whenSelectionChanged: `@statements' -> '`@receiver whenSelectionChangedDo: `@statements'.
	self whenSelectionChangedDo: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpDropListPresenter >> whenSelectionIndexChanged: aBlock [
	self deprecated: 'Use #whenSelectionIndexChangedDo: instead.' transformWith: '`@receiver whenSelectionIndexChanged: `@statements' -> '`@receiver whenSelectionIndexChangedDo: `@statements'.
	self whenSelectionIndexChangedDo: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpDropListPresenter >> whenSelectionIndexChangedDo: aBlock [
	"Set a block to perform when the selected index is changed"

	self deprecated: 'Use whenSelectionChanged:'.

	selection whenSelectionChanged: aBlock
]
