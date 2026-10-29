"
An announcement emitted when a tree node is expanded or collapsed.

It carries the tree item(s) that were expanded/collapsed and a boolean indicating whether it is now expanded.
"
Class {
	#name : 'SpTreeExpansionChanged',
	#superclass : 'Announcement',
	#instVars : [
		'expanded',
		'items'
	],
	#category : 'Spec2-ListView-Widget',
	#package : 'Spec2-ListView',
	#tag : 'Widget'
}

{ #category : 'accessing' }
SpTreeExpansionChanged >> expanded [

	^ expanded
]

{ #category : 'accessing' }
SpTreeExpansionChanged >> expanded: aBoolean [

	expanded := aBoolean
]

{ #category : 'accessing' }
SpTreeExpansionChanged >> item [
	"Backward compatibility: answer the single item when there is exactly one, otherwise the whole collection."

	^ self items size = 1
		  ifTrue: [ self items anyOne ]
		  ifFalse: [ self error: 'This announcement concern more than one element.' ]
]

{ #category : 'accessing' }
SpTreeExpansionChanged >> item: anObject [
	"Backward compatibility: set a single item."

	self items: { anObject }
]

{ #category : 'accessing' }
SpTreeExpansionChanged >> items [

	^ items
]

{ #category : 'accessing' }
SpTreeExpansionChanged >> items: aCollection [
	items := aCollection
]
