"
A simple spinner.
"
Class {
	#name : 'SpSpinnerPresenter',
	#superclass : 'SpAbstractWidgetPresenter',
	#category : 'Spec2-Core-Widgets',
	#package : 'Spec2-Core',
	#tag : 'Widgets'
}

{ #category : 'specs' }
SpSpinnerPresenter class >> adapterName [
	
	^ #SpinnerAdapter
]

{ #category : 'documentation' }
SpSpinnerPresenter class >> documentFactoryMethodSelector [

	^ #newSpinner
]
