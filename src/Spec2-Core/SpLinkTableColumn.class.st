"
A column to display a link.

## Example
```
SpIndexTableColumn 
	title: 'Link' 
	evaluated: [ :anObject | anObject name ]
	action: [ :anObject | ""Execute something with this object"" ]
```
"
Class {
	#name : 'SpLinkTableColumn',
	#superclass : 'SpTableColumn',
	#instVars : [
		'action',
		'url'
	],
	#category : 'Spec2-Core-Widgets-Table',
	#package : 'Spec2-Core',
	#tag : 'Widgets-Table'
}

{ #category : 'instance creation' }
SpLinkTableColumn class >> title: aString evaluated: aBlock action: actionBlock [

	^ self new 
		title: aString;
		evaluated: aBlock;
		action: actionBlock;
		yourself
]

{ #category : 'instance creation' }
SpLinkTableColumn class >> title: aString evaluated: aBlock url: urlBlock [

	^ self new 
		title: aString;
		evaluated: aBlock;
		url: urlBlock;
		yourself
]

{ #category : 'visiting' }
SpLinkTableColumn >> acceptColumnVisitor: aBuilder [

	^ aBuilder visitLinkColumn: self
]

{ #category : 'accessing' }
SpLinkTableColumn >> action [
	^ action
]

{ #category : 'accessing' }
SpLinkTableColumn >> action: aBlock [
	action := aBlock
]

{ #category : 'accessing' }
SpLinkTableColumn >> url [
	^ url
]

{ #category : 'accessing' }
SpLinkTableColumn >> url: anObject [
	url := anObject
]
