Class {
	#name : #ToolBarPresenter,
	#superclass : #AbstractWidgetPresenter,
	#instVars : [
		'items'
	],
	#category : #'Spec-Core-Widgets'
}

{ #category : #specs }
ToolBarPresenter class >> adapterName [

	^ #ToolBarAdapter
]

{ #category : #specs }
ToolBarPresenter class >> defaultSpec [
	<spec: #default>
	
	^ #(ToolBarAdapter
		adapt: #(model))
]

{ #category : #adding }
ToolBarPresenter >> addItem: aToolbarItem [
	
	self addItem: aToolbarItem position: ITItemPosition left
]

{ #category : #adding }
ToolBarPresenter >> addItem: aToolbarItem position: aPosition [

	(items 
		at: aPosition
		ifAbsentPut: [ OrderedCollection new ])
		add: aToolbarItem
]

{ #category : #initialization }
ToolBarPresenter >> initialize [
	super initialize.
	items := Dictionary new asValueHolder
]

{ #category : #api }
ToolBarPresenter >> items [
	^ items value
]
