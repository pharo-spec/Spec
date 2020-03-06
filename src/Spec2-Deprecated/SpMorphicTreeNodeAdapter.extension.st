Extension { #name : #SpMorphicTreeNodeAdapter }

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeNodeAdapter >> buildWidget [
	^ SpTreeNodeModel new
		setItemFromBlock: self itemBlock;
		icon: self icon;
		setChildren: self childrenBlock;
		hasContents: self hasChildrenBlock;
		model: self container;
		nodeModel: self model
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeNodeAdapter >> childrenBlock [
	^ [ self model buildChildren ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeNodeAdapter >> container [
	^ self model container
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeNodeAdapter >> deselect [

	self widgetDo: [ :w |
		w changed: #deselect.
		w model selectionChanged.
		w dependents do: [ :e | e changed ] ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeNodeAdapter >> hasChildrenBlock [
	^ self model hasChildren
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeNodeAdapter >> hasContentToShow [
	^ self model hasContentToShow
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeNodeAdapter >> icon [
	^ self model icon
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeNodeAdapter class >> isDeprecated [ 

	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeNodeAdapter >> isExpanded: aBoolean [

	
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeNodeAdapter >> item [
	^ self model content
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeNodeAdapter >> itemBlock [
	^ [ self item ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeNodeAdapter >> select [

	self widgetDo: [ :w |
		w changed: #select.
		w model selectionChanged.
		w dependents do: [ :e | e changed ] ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeNodeAdapter >> selected [
	^ self model selected
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeNodeAdapter >> selected: aBoolean [

	aBoolean 
		ifTrue: [ self select ]
		ifFalse: [ self deselect ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeNodeAdapter >> takeHighlight [

	self widgetDo: [ :w | w changed: #takeHighlight ]
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeNodeAdapter >> updateAccordingTo: aFilter [

	self widgetDo: [ :w |
		w contents do: [ :n | n nodeModel updateAccordingTo: aFilter ].
		w contents removeAllSuchThat: [ :n | (aFilter keepTreeNode: n nodeModel) not  and: [ n nodeModel isEmpty ] ] ]
]
