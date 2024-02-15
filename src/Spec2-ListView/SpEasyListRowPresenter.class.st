Class {
	#name : 'SpEasyListRowPresenter',
	#superclass : 'SpPresenter',
	#traits : 'SpTModel',
	#classTraits : 'SpTModel classTrait',
	#instVars : [
		'listView',
		'iconPresenter',
		'textPresenter'
	],
	#category : 'Spec2-ListView',
	#package : 'Spec2-ListView'
}

{ #category : 'layout' }
SpEasyListRowPresenter >> defaultLayout [

	^ self textLayout
]

{ #category : 'layout' }
SpEasyListRowPresenter >> iconLayout [

	^ SpBoxLayout newHorizontal
		spacing: 5;
		add: iconPresenter expand: false;
		add: textPresenter;
		yourself
]

{ #category : 'initialization' }
SpEasyListRowPresenter >> initializePresenters [

	iconPresenter := self newImage.
	textPresenter := self newLabel
]

{ #category : 'accessing' }
SpEasyListRowPresenter >> listView [

	^ listView
]

{ #category : 'accessing' }
SpEasyListRowPresenter >> listView: aListView [

	listView := aListView.
	listView hasIcons
		ifTrue: [ self useIconLayout ]
		ifFalse: [ self useTextLayout ]
]

{ #category : 'layout' }
SpEasyListRowPresenter >> textLayout [

	^ SpBoxLayout newHorizontal
		add: textPresenter;
		yourself
]

{ #category : 'initialization' }
SpEasyListRowPresenter >> updatePresenter [

	self model ifNil: [ ^ self ].
	
	self listView hasIcons
		ifTrue: [ iconPresenter image: (self listView displayIcon value: self model) ].
	textPresenter label: (self listView display value: self model)
]

{ #category : 'layout' }
SpEasyListRowPresenter >> useIconLayout [

	self layout: self iconLayout
]

{ #category : 'layout' }
SpEasyListRowPresenter >> useTextLayout [

	self layout: self textLayout
]
