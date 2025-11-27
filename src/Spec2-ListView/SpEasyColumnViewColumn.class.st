"
An easy version of the column that accepts a presenter as definition
"
Class {
	#name : 'SpEasyColumnViewColumn',
	#superclass : 'SpColumnViewColumn',
	#instVars : [
		'cellPresenterClass'
	],
	#category : 'Spec2-ListView-Easy',
	#package : 'Spec2-ListView',
	#tag : 'Easy'
}

{ #category : 'accessing' }
SpEasyColumnViewColumn class >> defaultCellPresenterClass [ 

	^ SpEasyColumnCellPresenter
]

{ #category : 'accessing' }
SpEasyColumnViewColumn >> cellPresenterClass [

	^ cellPresenterClass ifNil: [ cellPresenterClass := self class defaultCellPresenterClass ]
]

{ #category : 'accessing' }
SpEasyColumnViewColumn >> cellPresenterClass: aPresenterClass [

	cellPresenterClass := aPresenterClass
]

{ #category : 'initialization' }
SpEasyColumnViewColumn >> initialize [

	super initialize. 
	self setup: [ :aPresenter | aPresenter instantiate: self cellPresenterClass ]. 
	self bind: [ :aPresenter :anObject | aPresenter model: anObject ]
]
