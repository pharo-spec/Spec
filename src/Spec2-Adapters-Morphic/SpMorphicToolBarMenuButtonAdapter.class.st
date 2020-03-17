"
I'm the adapter used to bridge a ToolBarMenuButton and its morphic representation.
"
Class {
	#name : #SpMorphicToolBarMenuButtonAdapter,
	#superclass : #SpMorphicToolBarButtonAdapter,
	#instVars : [
		'subMenuWidget'
	],
	#category : #'Spec2-Adapters-Morphic-Base'
}

{ #category : #accessing }
SpMorphicToolBarMenuButtonAdapter >> action [ 

	self presenter menu ifNotNil: [ :aValuable |
		aValuable value ifNotNil: [ :aMenu |
			aMenu owner: self presenter.
			self showSubMenu: aMenu ] ].
	
	self widget ifNotNil: [ :m | 
		m takeKeyboardFocus ] 
]

{ #category : #protocol }
SpMorphicToolBarMenuButtonAdapter >> askBeforeChanging [

	^ false
]

{ #category : #'as yet unclassified' }
SpMorphicToolBarMenuButtonAdapter >> badge [
	
	^ self presenter badge
]

{ #category : #factory }
SpMorphicToolBarMenuButtonAdapter >> buildWidget [
	| button |
	
	button := (self morphClass
			on: self
			getState: nil 
			action: #action)
		helpText: self model help;
		beIconTop;
		hResizing: #rigid;
		vResizing: #spaceFill;
		borderWidth: 0;
		borderColor: Color transparent;		
		cellPositioning: #center;
		yourself.
		
	^ button
]

{ #category : #accessing }
SpMorphicToolBarMenuButtonAdapter >> defaultIcon [
		
	^ self application iconNamed: #arrowDown
]

{ #category : #control }
SpMorphicToolBarMenuButtonAdapter >> deleteIfPopUp: anEvent [ 
	
]

{ #category : #'drag and drop' }
SpMorphicToolBarMenuButtonAdapter >> dragEnabled [

	^ false
]

{ #category : #'drag and drop' }
SpMorphicToolBarMenuButtonAdapter >> dropEnabled [

	^ false
]

{ #category : #accessing }
SpMorphicToolBarMenuButtonAdapter >> icon [

	^ self presenter icon ifNil: [ self defaultIcon ]
]

{ #category : #testing }
SpMorphicToolBarMenuButtonAdapter >> isSelected: aBooolean [
]

{ #category : #accessing }
SpMorphicToolBarMenuButtonAdapter >> label [
	
	^ self presenter label
]

{ #category : #'widget API' }
SpMorphicToolBarMenuButtonAdapter >> showSubMenu: aMenu [ 

	aMenu menuGroups ifNil: [ ^ self ].
	 
	subMenuWidget ifNotNil: [ 
		subMenuWidget delete.
		subMenuWidget := nil ].
	subMenuWidget := (SpMorphicMenuAdapter adaptAsPopup: aMenu) widget.
	subMenuWidget
		popUpAdjacentTo: { 
			self widget bounds bottomLeft.
			self widget bounds bottomRight }
		forHand: ActiveHand
		from: self widget.
	subMenuWidget popUpOwner: self
]
