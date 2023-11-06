Class {
	#name : 'SpSliderPresenterBackendTest',
	#superclass : 'SpAbstractWidgetAdapterTest',
	#category : 'Spec2-Backend-Tests-Base',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Base'
}

{ #category : 'accessing' }
SpSliderPresenterBackendTest >> classToTest [
	^ SpSliderPresenter 
]

{ #category : 'initialization' }
SpSliderPresenterBackendTest >> initializeTestedInstance [
	presenter
		min: 1;
		max: 100;
		quantum: 1;
		value: 20
]

{ #category : 'tests' }
SpSliderPresenterBackendTest >> testSmokeHorizontalTest [
	self presenter beHorizontal.
]

{ #category : 'tests' }
SpSliderPresenterBackendTest >> testSmokeVerticalTest [
	self presenter beVertical.
	
]
