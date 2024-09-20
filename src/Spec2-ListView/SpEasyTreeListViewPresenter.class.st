Class {
	#name : 'SpEasyTreeListViewPresenter',
	#superclass : 'SpAbstractEasyTreeListViewPresenter',
	#instVars : [
		'#headerPanel',
		'#display => ObservableSlot',
		'#displayIcon => ObservableSlot',
		'#rowPresenterClass'
	],
	#category : 'Spec2-ListView-Easy',
	#package : 'Spec2-ListView',
	#tag : 'Easy'
}

{ #category : 'accessing' }
SpEasyTreeListViewPresenter class >> defaultRowPresenterClass [

	^ SpEasyListRowPresenter
]

{ #category : 'initialization' }
SpEasyTreeListViewPresenter >> initializePresenters [

	super initializePresenters.

	headerPanel := self newLabel.
	contentView := self newTreeListView
		setup: [ :aPresenter | 
			(aPresenter instantiate: self rowPresenterClass)
				listView: self;
				yourself ];
		bind: [ :aPresenter :anObject | 
			aPresenter model: anObject ];
		yourself.
		
	headerPanel hide
]

{ #category : 'api' }
SpEasyTreeListViewPresenter >> rowPresenterClass [

	^ rowPresenterClass ifNil: [ rowPresenterClass := self class defaultRowPresenterClass ]
]

{ #category : 'api' }
SpEasyTreeListViewPresenter >> rowPresenterClass: aPresenterClass [

	rowPresenterClass := aPresenterClass
]
