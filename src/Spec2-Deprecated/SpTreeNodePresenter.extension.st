Extension { #name : #SpTreeNodePresenter }

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter class >> adapterName [

	^ #TreeNodeAdapter
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> allSelectedItems [
	| result |
	
	result := OrderedCollection new.
	self selected ifTrue: [ result add: self ].
	self children value do: [ :e | 
		result addAll: e allSelectedItems ].
	^ result
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> allUnselectedItems [
	| result |
	
	result := OrderedCollection new.
	self selected ifFalse: [ result add: self ].
	self children value do: [ :e | 
		result addAll: e allUnselectedItems ].
	^ result
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> buildChildren [

	contents := self children value collect: [ :each || node | 
		node := (each isKindOf: SpTreeNodePresenter)
			ifTrue: [ each ]
			ifFalse: [  (self childNodeClassFor: each) new
				content: each  ].
		node 
			parentNode: self;
			yourself ].
		
	^ contents
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> childNodeClass [

	^ childNodeClass value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> childNodeClass: aBlock [

	childNodeClass value: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> childNodeClassFor: anItem [

	^ childNodeClass value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> children [

	^ children value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> children: aBlock [

	children value: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> container [

	^ container value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> container: anObject [

	container value: anObject
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> content [

	^ content value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> content: anObject [

	content value: anObject
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> contents [
	^ contents ifNil: [ 
		self buildChildren.
		contents ]
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> hasChildren [

	^ hasChildren value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> hasChildren: aBlock [

	hasChildren value: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> hasContentToShow [

	^ hasContentToShow value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> hasContentToShow: aBlock [

	hasContentToShow value: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> icon [

	^ icon value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> icon: anIcon [

	icon value: anIcon
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> iconName: aSelector [

	icon value: (self iconNamed: aSelector)
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> initialize [

	super initialize.

	children := [ self container childrenFor: self content ] asValueHolder.
	hasChildren := [ self container hasChildrenFor: self content ] asValueHolder.
	content := nil asValueHolder.
	icon := nil asValueHolder.
	container := nil asValueHolder.
	matchTokenFilter := [ :aFilter | false ] asValueHolder.
	parentNode := nil asValueHolder.
	childNodeClass := self class asValueHolder.
	selected := false asValueHolder.
	lastClicked := false asValueHolder.
	mouseDownAction := [:event | ] asValueHolder.
	hasContentToShow := false asValueHolder.
	isExpanded := false asValueHolder.
	
	selected whenChangedDo: [ :aBoolean | self changed: #selected: with: { aBoolean } ].
	isExpanded whenChangedDo: [ :aBoolean | self changed: #isExpanded: with: { aBoolean } ].
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter class >> isDeprecated [ 

	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> isEmpty [
	^ self contents isEmpty
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> isExpanded [
	
	^ isExpanded value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> isExpanded: aBoolean [

	isExpanded value: aBoolean
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> isPartialMatch [
	| result |

	result := false.
	
	self children value do: [:each | 
		(each selected or: [ each isPartialMatch ]) ifTrue: [ result := true ] ].

	^ result
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> lastClicked [
	
	^ lastClicked value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> lastClicked: aBoolean [

	lastClicked value: aBoolean
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> matchTokenFilter: aFilter [

	^ self matchTokenFilterBlock value: aFilter
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> matchTokenFilterBlock [

	^ matchTokenFilter value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> matchTokenFilterBlock: aBlock [

	matchTokenFilter value: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> mouseDownAction [

	^ mouseDownAction value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> mouseDownAction: aBlock [

	mouseDownAction value: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> parentNode [

	^ parentNode value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> parentNode: aNode [

	parentNode value: aNode
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> selectAllChildren [

	self children value do: [ :e | 
		e selected: true.
		e selectAllChildren ].
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> selected [
	
	^ selected value
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> selected: aBoolean [

	selected value: aBoolean
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> takeHighlight [

	self changed: #takeHighlight with: #()
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> unselectAllChildren [

	self children value do: [ :e | 
		e selected: false.
		e unselectAllChildren ].	
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> updateAccordingTo: aFilter [

	(aFilter keepTreeNode: self) 
		ifFalse: [
			self changed: #updateAccordingTo: with: { aFilter } ]
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> whenContentChanged: aBlock [
	self deprecated: 'Use #whenContentChangedDo: instead.' transformWith: '`@receiver whenContentChanged: `@statements' -> '`@receiver whenContentChangedDo: `@statements'.
	self whenContentChangedDo: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> whenContentChangedDo: aBlock [

	content whenChangedDo: aBlock

	
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> whenIsExpandedChanged: aBlock [
	self deprecated: 'Use #whenIsExpandedChangedDo: instead.' transformWith: '`@receiver whenIsExpandedChanged: `@statements' -> '`@receiver whenIsExpandedChangedDo: `@statements'.
	self whenIsExpandedChangedDo: aBlock

	
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> whenIsExpandedChangedDo: aBlock [

	isExpanded whenChangedDo: aBlock

	
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> whenSelectedChanged: aBlock [
	self deprecated: 'Use #whenSelectedChangedDo: instead.' transformWith: '`@receiver whenSelectedChanged: `@statements' -> '`@receiver whenSelectedChangedDo: `@statements'.
	self whenSelectedChangedDo: aBlock
]

{ #category : #'*Spec2-Deprecated' }
SpTreeNodePresenter >> whenSelectedChangedDo: aBlock [

	selected whenChangedDo: aBlock

	
]
