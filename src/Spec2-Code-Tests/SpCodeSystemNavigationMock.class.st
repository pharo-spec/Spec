Class {
	#name : #SpCodeSystemNavigationMock,
	#superclass : #SystemNavigation,
	#instVars : [
		'messageList',
		'browseClass',
		'browseSelector'
	],
	#category : #'Spec2-Code-Tests'
}

{ #category : #opening }
SpCodeSystemNavigationMock >> browse: aClass [

	browseClass := aClass
]

{ #category : #accessing }
SpCodeSystemNavigationMock >> browseClass [

	^ browseClass
]

{ #category : #'as yet unclassified' }
SpCodeSystemNavigationMock >> browseHierarchy: aClass selector: aSelector [

	browseClass := aClass.
	browseSelector := aSelector
]

{ #category : #enumerating }
SpCodeSystemNavigationMock >> browseMessageList: aList name: labelString autoSelect: autoSelectString refreshingBlock: aBlock [

	messageList 	:= aList
	
]

{ #category : #accessing }
SpCodeSystemNavigationMock >> browseSelector [

	^ browseSelector
]

{ #category : #accessing }
SpCodeSystemNavigationMock >> messageList [

	^ messageList
]

{ #category : #accessing }
SpCodeSystemNavigationMock >> reset [

	browseClass := nil.
	browseSelector := nil.	
	messageList := nil

]
