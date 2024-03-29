"
A SpecLayoutAddRow is an action representing the addition of a row to a layout

"
Class {
	#name : 'SpLayoutAddRow',
	#superclass : 'SpLayoutAdd',
	#category : 'Spec2-Layout-Deprecated',
	#package : 'Spec2-Layout-Deprecated'
}

{ #category : 'instance creation' }
SpLayoutAddRow class >> block: aBlock layoutFrame: aLayoutFrame [

	^ self new
			block: aBlock 
			layoutFrame: aLayoutFrame;
			yourself
]

{ #category : 'Spec2-Deprecated' }
SpLayoutAddRow >> block: aBlock layoutFrame: aLayoutFrame [
	| row |
	row := SpRowLayout composed.
	aBlock value: row.
	subwidget := row.
	self layoutFrame: aLayoutFrame
]
