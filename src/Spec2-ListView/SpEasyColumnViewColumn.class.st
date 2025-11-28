"
An easy version of the column that accepts a presenter as definition.
In addition to the common properties of a column (`title`, etc.), this columns accepts a `cellPresenterClass` which will be used to display the cell content.

### Defining cell presenters
The easy column view presenter implements `cellPresenterClass:`. This message allows users to define their own arbitrary presenters to use with lists. This presenters however require two conditions to be fulfilled: 
- they need to implement `model:`. This is used receive the element to be displayed. This can be achieved by using `SpTModel` presenter, for example)
- they need to implement `listView:`. This is used to set the list that ""owns"" the row element, which can be used to get contextual information.

**Important:** The easiest way to fulfill this conditions is to extent `SpEasyAbstractRowPresenter`. Look at its hierarchy for examples.

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
