"
A small inspector to be used in the demos.

```
self example
```
"
Class {
	#name : 'SpDemoObjectInspectorPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'variablesList',
		'variableValueCode',
		'evaluatorCode',
		'inspectedObject'
	],
	#category : 'Spec2-Examples-Standalone',
	#package : 'Spec2-Examples',
	#tag : 'Standalone'
}

{ #category : 'examples' }
SpDemoObjectInspectorPresenter class >> example [

	self inspect: self new
]

{ #category : 'instance creation' }
SpDemoObjectInspectorPresenter class >> inspect: anObject [

	^ self new 
		inspect: anObject;
		open
]

{ #category : 'initialization' }
SpDemoObjectInspectorPresenter >> initializePresenters [

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

{ #category : 'instance creation' }
SpDemoObjectInspectorPresenter >> inspect: anObject [

	inspectedObject := anObject.
	self updatePresenter
]

{ #category : 'initialization' }
SpDemoObjectInspectorPresenter >> updatePresenter [

	variablesList items: inspectedObject class allSlots
]

{ #category : 'accessing' }
SpDemoObjectInspectorPresenter >> windowTitle [

	^ 'Object Inspector'
]
