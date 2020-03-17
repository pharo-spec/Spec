Class {
	#name : #SpToolBarMenuButton,
	#superclass : #SpToolBarButton,
	#instVars : [
		'menu'
	],
	#category : #'Spec2-Core-Widgets-Toolbar'
}

{ #category : #specs }
SpToolBarMenuButton class >> adapterName [

	^ #ToolBarMenuButtonAdapter
]

{ #category : #initialization }
SpToolBarMenuButton >> initialize [

	super initialize.
	self addStyle: 'button'
]

{ #category : #accessing }
SpToolBarMenuButton >> menu [
	^ menu
]

{ #category : #accessing }
SpToolBarMenuButton >> menu: anObject [
	menu := anObject
]
