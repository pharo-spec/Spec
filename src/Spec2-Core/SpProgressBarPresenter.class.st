"
A presenter used to define a progress bar.

`SpProgressBarPresenter` uses a strategy to define the kind of progress ba (It can be fixed at a value, indetermineted or progressing).
"
Class {
	#name : #SpProgressBarPresenter,
	#superclass : #SpAbstractWidgetPresenter,
	#instVars : [
		'state'
	],
	#category : #'Spec2-Core-Widgets'
}

{ #category : #specs }
SpProgressBarPresenter class >> adapterName [

	^ #ProgressBarAdapter
]

{ #category : #documentation }
SpProgressBarPresenter class >> documentFactoryMethodSelector [

	^ #newProgressBar
]

{ #category : #api }
SpProgressBarPresenter >> fixedAt: aNumber [
	"Declare that the progress bar will be fixed at a certain value. 
	 The value should be the completed ratio between 0 and 1."
	
	self state: (SpFixedProgressBarState value: aNumber)
]

{ #category : #api }
SpProgressBarPresenter >> fixedPercentage: aNumber [
	"Declare that the progress bar will be fixed at a certain value. 
	 The value should be in percent"

	self fixedAt: aNumber percent
]

{ #category : #api }
SpProgressBarPresenter >> indeterminate [
	"If selected, the progress bar will go back and forth without any clear progression. 
	 Use it do show a progress bar with indeterminate progression."

	self state: SpIndeterminatedProgressBarState new
]

{ #category : #initialization }
SpProgressBarPresenter >> initialize [

	super initialize.
	self fixedAt: 0
]

{ #category : #api }
SpProgressBarPresenter >> progress: aBlock [
	"Using this option, the progress bar will increase with time. 
	 The progression block should return the progression between 0 and 1."

	self progress: aBlock every: 0.2 second
]

{ #category : #api }
SpProgressBarPresenter >> progress: aBlock every: aDelay [
	"Using this option, the progress bar will increase with time. 
	 The progression block should return the progression between 0 and 1 and 
	 the delay will be used to know the delay between two refresh."

	self state: (SpProgressingProgressBarState progression: aBlock every: aDelay)
]

{ #category : #private }
SpProgressBarPresenter >> state [

	^ state
]

{ #category : #private }
SpProgressBarPresenter >> state: aState [

	state := aState.
	self withAdapterPerformOrDefer: [ :anAdapter | anAdapter updateState ]
]

{ #category : #'api-events' }
SpProgressBarPresenter >> whenValueChangedDo: aBlock [
	"Inform when progress value has changed. 
	 `aBlock` has three optional arguments: 
	 - new value
	 - old value
	 - the announcement triggering this action"

	self property: #state whenChangedDo: aBlock
]
