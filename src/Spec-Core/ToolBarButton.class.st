"
A button with an icon and label associated with an action and a badge 
"
Class {
	#name : #ToolBarButton,
	#superclass : #SpToolBarItemPresenter,
	#instVars : [
		'label',
		'icon',
		'action',
		'badge'
	],
	#category : #'Spec-Core-Widgets-Toolbar'
}

{ #category : #specs }
ToolBarButton class >> adapterName [

	^ #ToolBarButtonAdapter
]

{ #category : #accessing }
ToolBarButton >> action [
	^ action
]

{ #category : #accessing }
ToolBarButton >> action: anObject [
	action := anObject
]

{ #category : #accessing }
ToolBarButton >> badge [
	^ badge
]

{ #category : #accessing }
ToolBarButton >> badge: aString [
	badge := aString
]

{ #category : #simulating }
ToolBarButton >> click [
	
	self execute
]

{ #category : #execution }
ToolBarButton >> execute [
	self action cull: self
]

{ #category : #accessing }
ToolBarButton >> icon [
	^ icon
]

{ #category : #accessing }
ToolBarButton >> icon: anObject [
	icon := anObject
]

{ #category : #accessing }
ToolBarButton >> label [
	^ label
]

{ #category : #accessing }
ToolBarButton >> label: anObject [
	label := anObject
]
