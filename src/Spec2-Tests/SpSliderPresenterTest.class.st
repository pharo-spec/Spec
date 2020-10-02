Class {
	#name : #SpSliderPresenterTest,
	#superclass : #SpSmokeTest,
	#category : #'Spec2-Tests-Core-Widgets'
}

{ #category : #running }
SpSliderPresenterTest >> classToTest [
	^ SpSliderPresenter
]

{ #category : #running }
SpSliderPresenterTest >> initMinMax [
 presenter min: 0;
		max: 100
]

{ #category : #tests }
SpSliderPresenterTest >> testAbsoluteValue [
	self initMinMax.
	presenter absoluteValue: 0.5.
	self assert: presenter value == 50
]

{ #category : #tests }
SpSliderPresenterTest >> testAbsoluteValueToValueScales [
	self initMinMax.
	self assert:  (presenter absoluteValueToValue: 0.5) equals: 50
]

{ #category : #tests }
SpSliderPresenterTest >> testReset [
	self initMinMax.
	presenter
		value: 50;
		reset.
	self assert: presenter value == 0
]

{ #category : #tests }
SpSliderPresenterTest >> testValueEqualsScaled [

	self initMinMax.
	presenter whenValueChangedDo: [ :v | presenter label: v asString ].
	presenter value: 4.
	self assert: presenter label equals: '4'.
	presenter
		min: -1 / 2;
		max: 1 / 2.
	presenter value: 0.25.
	self assert: presenter label equals: '0.25'.
	presenter value: 1.
	self assert: presenter label equals: '1'.
	presenter
		min: -0.257;
		max: 4096.0.
	presenter value: 4095.99.
	self assert: presenter label equals: '4095.99'
]

{ #category : #tests }
SpSliderPresenterTest >> testValueToAbsoluteValueScales [
	self initMinMax.
	self assert:  (presenter valueToAbsoluteValue: 50) equals: 0.5
]
