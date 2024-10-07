Class {
	#name : 'SpSliderAdapterTest',
	#superclass : 'SpAbstractWidgetAdapterTest',
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpSliderAdapterTest >> classToTest [
	^ SpSliderPresenter 
]

{ #category : 'tests' }
SpSliderAdapterTest >> testChangeInLabelUpdatesWidget [

	self
		assert: self adapter widgetLabel
		closeTo: ''.

	presenter label: 'test'.

	self
		assert: self adapter widgetLabel
		equals: 'test'
]

{ #category : 'tests' }
SpSliderAdapterTest >> testChangeInMaxUpdatesWidget [

	presenter value: 80.

	"Default max is 100"
	self
		assert: self adapter widgetAbsoluteValue
		closeTo: 0.8.
	self
		assert: self adapter widgetValue
		equals: 80.

	"Changing max updates the slider value"
	presenter max: 1000.
	self
		assert: self adapter widgetAbsoluteValue
		closeTo: 0.8.
	self
		assert: self adapter widgetValue
		equals: 800
]

{ #category : 'tests' }
SpSliderAdapterTest >> testChangeInMinUpdatesWidget [

	presenter value: 80.

	"Default min is 0"
	self
		assert: self adapter widgetAbsoluteValue
		closeTo: 0.8.
	self
		assert: self adapter widgetValue
		equals: 80.

	"Changing min updates the slider value"
	presenter min: 50.
	self
		assert: self adapter widgetAbsoluteValue
		closeTo: 0.8.
	self
		assert: self adapter widgetValue
		equals: 90
]

{ #category : 'tests' }
SpSliderAdapterTest >> testChangeInQuantumUpdatesWidget [

	presenter
		min: -50;
		max: 150.

	"By default, quantum is 1, which means round Floats to Integer"
	presenter value: 49.1.
	self assert: self adapter widgetValue closeTo: 49.

	presenter value: -49.1.
	self assert: self adapter widgetValue closeTo: -49.

	"Quantum is disabled when nil is set"
	presenter quantum: nil.

	presenter value: 49.1.
	self assert: self adapter widgetValue closeTo: 49.1.

	presenter value: -49.1.
	self assert: self adapter widgetValue closeTo: -49.1.

	"Set 50 as quantum"
	presenter quantum: 10.

	"Current value is automatically rounded acording to the new quamtum"
	self assert: self adapter widgetValue equals: -50.

	"It also works with new values"
	presenter value: 49.
	self assert: self adapter widgetValue equals: 50
]

{ #category : 'tests' }
SpSliderAdapterTest >> testChangeInValueUpdatesWidget [

	presenter
		min: -50;
		max: 150.

	presenter value: 50.
	self assert: self adapter widgetValue equals: 50.

	presenter value: -50.
	self assert: self adapter widgetValue equals: -50
]

{ #category : 'tests' }
SpSliderAdapterTest >> testPresenterUpdatesWidget [

	presenter
		min: -50;
		max: 150.

	presenter value: 50.
	self assert: self adapter widgetValue equals: 50.

	presenter value: -50.
	self assert: self adapter widgetValue equals: -50.

	"By default, quantum is 1, which means round Floats to Integer"
	presenter value: 49.1.
	self assert: self adapter widgetValue closeTo: 49.

	presenter value: -49.1.
	self assert: self adapter widgetValue closeTo: -49.

	"Quantum is disabled when nil is set"
	presenter quantum: nil.

	presenter value: 49.1.
	self assert: self adapter widgetValue closeTo: 49.1.

	presenter value: -49.1.
	self assert: self adapter widgetValue closeTo: -49.1.

	"Set 50 as quantum"
	presenter quantum: 10.

	"Current value is automatically rounded acording to the new quamtum"
	self assert: self adapter widgetValue equals: -50.

	"It also works with new values"
	presenter value: 49.
	self assert: self adapter widgetValue equals: 50
]

{ #category : 'tests' }
SpSliderAdapterTest >> testWidgetUpdatesPresenter [

	presenter
		min: -50;
		max: 150;
		quantum: 10.

	"Emulate a change on the widget"
	self adapter widgetValue: 54.

	self assert: presenter value equals: 50.
	self assert: presenter absoluteValue equals: 0.5
]
