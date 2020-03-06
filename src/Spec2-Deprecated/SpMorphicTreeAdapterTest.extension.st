Extension { #name : #SpMorphicTreeAdapterTest }

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapterTest class >> isDeprecated [
	^ true
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapterTest >> modelClass [
	^ SpTreePresenter
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapterTest >> setUp [
	super setUp.
	treeWithItems := self modelClass new.
	treeWithItems roots: #(#first #second #third #fourth #fifth)
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapterTest >> testDefaultRowColors [
	| defaultColor |
	defaultColor := Smalltalk ui theme backgroundColor.
	treeWithItems buildWithSpec.
	self
		assert: treeWithItems adapter widget rowColors
		equals: (Array with: defaultColor with: defaultColor)
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapterTest >> testRowColorsAfterBuild [
	treeWithItems buildWithSpec.
	treeWithItems oddRowColor: Color red.
	treeWithItems evenRowColor: Color green.
	self
		assert: treeWithItems adapter widget rowColors
		equals: (Array with: Color green with: Color red)
]

{ #category : #'*Spec2-Deprecated' }
SpMorphicTreeAdapterTest >> testRowColorsBeforeBuild [
	treeWithItems oddRowColor: Color red.
	treeWithItems evenRowColor: Color green.
	treeWithItems buildWithSpec.
	self
		assert: treeWithItems adapter widget rowColors
		equals: (Array with: Color green with: Color red)
]
