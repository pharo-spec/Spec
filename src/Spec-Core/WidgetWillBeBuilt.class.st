"
I am raised when a widget will be built. 

I may be used in situations when you need to change the content of the context menu before it will be displayed and so on.
"
Class {
	#name : #WidgetWillBeBuilt,
	#superclass : #Announcement,
	#instVars : [
		'model'
	],
	#category : #'Spec-Core-Support'
}

{ #category : #'instance creation' }
WidgetWillBeBuilt class >> model: model [

	^ self new
		model: model;
		yourself
]

{ #category : #accessing }
WidgetWillBeBuilt >> model [
	^ model
]

{ #category : #accessing }
WidgetWillBeBuilt >> model: anObject [
	model := anObject
]
