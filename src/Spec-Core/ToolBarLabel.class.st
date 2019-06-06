"
A label
"
Class {
	#name : #ToolBarLabel,
	#superclass : #ToolBarItemPresenter,
	#instVars : [
		'contents'
	],
	#category : #'Spec-Core-Widgets-Toolbar'
}

{ #category : #specs }
ToolBarLabel class >> adapterName [

	^ #ToolBarLabelAdapter
]

{ #category : #accessing }
ToolBarLabel >> contents [
	^ contents
]

{ #category : #accessing }
ToolBarLabel >> contents: anObject [
	contents := anObject
]
