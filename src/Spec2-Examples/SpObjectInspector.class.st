"
A small inspector to be used in the demos.

```
self example
```
"
Class {
	#name : #SpObjectInspector,
	#superclass : #SpPresenter,
	#instVars : [
		'variablesList',
		'variableValueCode',
		'evaluatorCode',
		'inspectedObject'
	],
	#category : #'Spec2-Examples-Standalone'
}

{ #category : #examples }
SpObjectInspector class >> example [

	self inspect: self new
]

{ #category : #'instance creation' }
SpObjectInspector class >> inspect: anObject [

	^ self new 
		inspect: anObject;
		open
]

{ #category : #initialization }
SpObjectInspector >> initializePresenters [

	self layout: (SpPanedLayout newTopToBottom
		positionOfSlider: 70 percent;
		add: (SpPanedLayout newLeftToRight
			add: (variablesList := self newList);
			add: (variableValueCode := self newCode);
			yourself);
		add: (evaluatorCode := self newCode);
		yourself).
		
	variablesList display: [ :aSlot | aSlot name ]
]

{ #category : #'instance creation' }
SpObjectInspector >> inspect: anObject [

	inspectedObject := anObject.
	self updatePresenter
]

{ #category : #initialization }
SpObjectInspector >> updatePresenter [

	variablesList items: inspectedObject class allSlots
]
