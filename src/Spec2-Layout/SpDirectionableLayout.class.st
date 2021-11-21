"
I'm just an intermediary class offering handy initialization methods such as `beTopToBottom` and `beLeftToRight`.
"
Class {
	#name : #SpDirectionableLayout,
	#superclass : #SpExecutableLayout,
	#instVars : [
		'direction'
	],
	#category : #'Spec2-Layout-Paned'
}

{ #category : #'instance creation' }
SpDirectionableLayout class >> new [ 

	^ super new beVertical
]

{ #category : #'instance creation' }
SpDirectionableLayout class >> newHorizontal [

	^ self newLeftToRight
]

{ #category : #'instance creation' }
SpDirectionableLayout class >> newLeftToRight [

	^ super new beHorizontal
]

{ #category : #'instance creation' }
SpDirectionableLayout class >> newTopToBottom [

	^ super new beVertical
]

{ #category : #'instance creation' }
SpDirectionableLayout class >> newVertical [ 

	^ self newTopToBottom 
]

{ #category : #'initialization - deprecated' }
SpDirectionableLayout >> beHorizontal [
	"Avoid to use me and favor beLeftToRight and is a lot cooler."
	direction := SpLayoutDirection horizontal
]

{ #category : #initialization }
SpDirectionableLayout >> beLeftToRight [

	direction := SpLayoutDirection horizontal
]

{ #category : #initialization }
SpDirectionableLayout >> beTopToBottom [

	direction := SpLayoutDirection vertical
]

{ #category : #'initialization - deprecated' }
SpDirectionableLayout >> beVertical [
	"Avoid to use me and favor beTopToBottom and is a lot cooler."
	
	direction := SpLayoutDirection vertical
]
