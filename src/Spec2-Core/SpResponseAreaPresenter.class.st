"
An area to place buttons following a conventional arrangement. 
This presenter replace `SpButtonBarPresenter` (which is old and not really useful) 
"
Class {
	#name : 'SpResponseAreaPresenter',
	#superclass : 'SpPresenter',
	#category : 'Spec2-Core-Windows',
	#package : 'Spec2-Core',
	#tag : 'Windows'
}

{ #category : 'api' }
SpResponseAreaPresenter >> add: aButtonPresenter [
	"adds a presenter to the list. 
	 in fact, it can be anything, not just a button, but the idea is to add buttons."
	
	self layout add: aButtonPresenter
]

{ #category : 'api' }
SpResponseAreaPresenter >> addDestructive: aButtonPresenter [

	self add: aButtonPresenter.
	self makeDestructive: aButtonPresenter
]

{ #category : 'api' }
SpResponseAreaPresenter >> addSuggested: aButtonPresenter [

	self add: aButtonPresenter.
	self makeSuggested: aButtonPresenter	
]

{ #category : 'layout' }
SpResponseAreaPresenter >> baseLayout [

	^ SpBoxLayout newLeftToRight
]

{ #category : 'api' }
SpResponseAreaPresenter >> beHomogeneous [

	self layout: self baseLayout beHomogeneous
]

{ #category : 'layout' }
SpResponseAreaPresenter >> defaultLayout [

	^ self baseLayout hAlignEnd
]

{ #category : 'initialization' }
SpResponseAreaPresenter >> initializePresenters [

	self addStyle: 'response-area'
]

{ #category : 'api' }
SpResponseAreaPresenter >> makeDestructive: aButtonPresenter [

	aButtonPresenter addStyle: 'destructive-action'
]

{ #category : 'api' }
SpResponseAreaPresenter >> makeSuggested: aButtonPresenter [

	aButtonPresenter addStyle: 'suggested-action'
]
