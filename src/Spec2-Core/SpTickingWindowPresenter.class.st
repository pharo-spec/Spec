"
In addition to my superclass, I provide an API to execute the `step` method every `stepTime`.
"
Class {
	#name : #SpTickingWindowPresenter,
	#superclass : #SpWindowPresenter,
	#category : #'Spec2-Core-Windows'
}

{ #category : #specs }
SpTickingWindowPresenter class >> adapterName [

	^ #TickingWindowAdapter
]

{ #category : #stepping }
SpTickingWindowPresenter >> step [
	self presenter step
]

{ #category : #stepping }
SpTickingWindowPresenter >> stepTime [
	^ self presenter stepTime
]
