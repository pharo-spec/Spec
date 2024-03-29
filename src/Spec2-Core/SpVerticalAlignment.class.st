"
I represent the vertical scrolling of a presenter.
You can ask the first and last index of the visible rows.
I can move the scrolling to make an element visible with the #desiredVisibleRow: method.
"
Class {
	#name : 'SpVerticalAlignment',
	#superclass : 'Object',
	#traits : 'TObservable',
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'#firstVisibleRowIndex',
		'#lastVisibleRowIndex',
		'#desiredVisibleRow => ObservableSlot'
	],
	#category : 'Spec2-Core-Widgets-Table',
	#package : 'Spec2-Core',
	#tag : 'Widgets-Table'
}

{ #category : 'accessing' }
SpVerticalAlignment >> desiredVisibleRow [
	^ desiredVisibleRow
]

{ #category : 'accessing' }
SpVerticalAlignment >> desiredVisibleRow: anInteger [
	desiredVisibleRow := anInteger
]

{ #category : 'accessing' }
SpVerticalAlignment >> firstVisibleRowIndex [
	"valid only after UI is open"

	^ firstVisibleRowIndex
]

{ #category : 'accessing' }
SpVerticalAlignment >> firstVisibleRowIndex: anInteger [
	firstVisibleRowIndex := anInteger
]

{ #category : 'initialization' }
SpVerticalAlignment >> initialize [
	self class initializeSlots: self.
	super initialize.
	desiredVisibleRow := 1
]

{ #category : 'initialization' }
SpVerticalAlignment >> lastVisibleRowIndex [
	^ lastVisibleRowIndex
]

{ #category : 'initialization' }
SpVerticalAlignment >> lastVisibleRowIndex: anInteger [
	lastVisibleRowIndex := anInteger
]

{ #category : 'initialization' }
SpVerticalAlignment >> whenChangedDo: aBlockClosure [
	self property: #desiredVisibleRow whenChangedDo: aBlockClosure
]
