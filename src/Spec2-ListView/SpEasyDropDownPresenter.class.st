Class {
	#name : 'SpEasyDropDownPresenter',
	#superclass : 'SpDropDownPresenter',
	#instVars : [
		'rowPresenterClass',
		'displayIcon'
	],
	#category : 'Spec2-ListView-Easy',
	#package : 'Spec2-ListView',
	#tag : 'Easy'
}

{ #category : 'accessing' }
SpEasyDropDownPresenter class >> defaultRowPresenterClass [

	^ SpEasyListRowPresenter
]

{ #category : 'api' }
SpEasyDropDownPresenter >> displayIcon [

	^ displayIcon
]

{ #category : 'api' }
SpEasyDropDownPresenter >> displayIcon: aBlock [

	displayIcon := aBlock
]

{ #category : 'testing' }
SpEasyDropDownPresenter >> hasIcons [
	"Answer true if the list has an icon provider (See `SpDropDownPresenter>>#displayIcon:`)."

	^ self displayIcon isNotNil
]

{ #category : 'initialization' }
SpEasyDropDownPresenter >> initializeItemFactory [
	"Just set up the defaults (to ensure we have a working list at any moment)"
	
	self setup: [ :aPresenter | 
		(aPresenter instantiate: self rowPresenterClass)
			listView: self;
			yourself ].
	self bind: [ :aPresenter :anObject | 
		aPresenter model: anObject ]
]

{ #category : 'api' }
SpEasyDropDownPresenter >> rowPresenterClass [

	^ rowPresenterClass ifNil: [ rowPresenterClass := self class defaultRowPresenterClass ]
]

{ #category : 'api' }
SpEasyDropDownPresenter >> rowPresenterClass: aPresenterClass [

	rowPresenterClass := aPresenterClass
]

{ #category : 'api' }
SpEasyDropDownPresenter >> startWithSelection [
	
]
