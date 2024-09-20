Class {
	#name : 'SpDragAndDropTransfer',
	#superclass : 'Object',
	#instVars : [
		'passenger',
		'shouldCopy'
	],
	#category : 'Spec2-Adapters-Morphic-Support',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Support'
}

{ #category : 'accessing' }
SpDragAndDropTransfer >> passenger [

	^ passenger
]

{ #category : 'accessing' }
SpDragAndDropTransfer >> passenger: anObject [

	passenger := anObject
]

{ #category : 'accessing' }
SpDragAndDropTransfer >> shouldCopy [

	^ shouldCopy
]

{ #category : 'accessing' }
SpDragAndDropTransfer >> shouldCopy: anObject [

	shouldCopy := anObject
]
