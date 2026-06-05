"
An announcement emitted when a tree node is expanded or collapsed.

It carries the tree item that was expanded/collapsed and a boolean indicating whether it is now expanded.
"
Class {
	#name : 'SpTreeExpansionChanged',
	#superclass : 'Announcement',
	#instVars : [
		'item',
		'expanded'
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

	^ item
]

{ #category : 'accessing' }
SpTreeExpansionChanged >> item: anObject [

	item := anObject
]
