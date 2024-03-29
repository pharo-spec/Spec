"
I build cells for a MorphicTreeTableAdapter.
"
Class {
	#name : 'SpMorphicTreeTableCellBuilder',
	#superclass : 'SpMorphicTableCellBuilder',
	#instVars : [
		'item'
	],
	#category : 'Spec2-Adapters-Morphic-Table',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Table'
}

{ #category : 'accessing' }
SpMorphicTreeTableCellBuilder >> item [
	
	^ item
]

{ #category : 'accessing' }
SpMorphicTreeTableCellBuilder >> item: anObject [

	item := anObject
]
