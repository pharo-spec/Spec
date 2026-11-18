Class {
	#name : 'SpLabelPresenterTest',
	#superclass : 'SpSmokeTest',
	#category : 'Spec2-Tests-Core-Widgets',
	#package : 'Spec2-Tests',
	#tag : 'Core-Widgets'
}

{ #category : 'accessing' }
SpLabelPresenterTest >> classToTest [
	^ SpLabelPresenter
]

{ #category : 'tests' }
SpLabelPresenterTest >> testBeWrap [

	presenter beWrap.
	self assert: presenter isWrap.

	presenter beNotWrap.
	self deny: presenter isWrap
]

{ #category : 'tests' }
SpLabelPresenterTest >> testIsNotWrapByDefault [

	self deny: presenter isWrap
]

{ #category : 'tests' }
SpLabelPresenterTest >> testLabelChangeRaisesEvent [

	self
		assertEvent: #whenChangedDo:
		isRaisedInPresenter: presenter
		whenDoing: [ presenter label: 'test' ]
]

{ #category : 'tests' }
SpLabelPresenterTest >> testLabelChangeRaisesEventOnce [

	self
		assertWith: [ :times | times = 1 ]
		timesRaisedEvent: #whenChangedDo:
		inPresenter: presenter
		whenDoing: [ presenter label: 'test' ]
]

{ #category : 'tests' }
SpLabelPresenterTest >> testLabelIsSet [

	presenter label: 'test'.
	self assert: presenter label equals: 'test'
]

{ #category : 'tests' }
SpLabelPresenterTest >> testWhenWrapChangedDo [

	| newValues |
	newValues := OrderedCollection new.
	presenter whenWrapChangedDo: [ :aBoolean | newValues add: aBoolean ].

	presenter beWrap.
	presenter beNotWrap.

	self assert: newValues asArray equals: #( true false )
]
