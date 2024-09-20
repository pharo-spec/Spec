Class {
	#name : 'SpTreeColumnViewPresenter',
	#superclass : 'SpAbstractTreePresenter',
	#instVars : [
		'#columns => ObservableSlot',
		'#isResizable => ObservableSlot',
		'#showColumnHeaders => ObservableSlot'
	],
	#category : 'Spec2-ListView-Widget',
	#package : 'Spec2-ListView',
	#tag : 'Widget'
}

{ #category : 'initialization' }
SpTreeColumnViewPresenter >> initialize [

	super initialize.
	columns := #().
	
	self beSingleSelection.
	self activateOnDoubleClick.
	self beResizable.
	self showColumnHeaders
]
