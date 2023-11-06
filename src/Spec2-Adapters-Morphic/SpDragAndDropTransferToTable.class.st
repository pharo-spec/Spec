Class {
	#name : 'SpDragAndDropTransferToTable',
	#superclass : 'SpDragAndDropTransfer',
	#instVars : [
		'row',
		'column'
	],
	#category : 'Spec2-Adapters-Morphic-Support',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Support'
}

{ #category : 'accessing' }
SpDragAndDropTransferToTable >> column [

	^ column
]

{ #category : 'accessing' }
SpDragAndDropTransferToTable >> column: anInteger [

	column := anInteger
]

{ #category : 'accessing' }
SpDragAndDropTransferToTable >> row [

	^ row
]

{ #category : 'accessing' }
SpDragAndDropTransferToTable >> row: anInteger [

	row := anInteger
]
