Class {
	#name : #SpListViewPresenter,
	#superclass : #SpAbstractListPresenter,
	#traits : 'SpTSearchable',
	#classTraits : 'SpTSearchable classTrait',
	#instVars : [
		'#setupAction',
		'#bindAction'
	],
	#category : #'Spec2-Core-Widgets-ListView'
}

{ #category : #specs }
SpListViewPresenter class >> adapterName [

	^ #ListViewAdapter
]

{ #category : #api }
SpListViewPresenter >> bind: aBlock [

	bindAction := aBlock
]

{ #category : #private }
SpListViewPresenter >> bindAction [

	^ bindAction
]

{ #category : #api }
SpListViewPresenter >> setup: aBlock [

	setupAction := aBlock
]

{ #category : #private }
SpListViewPresenter >> setupAction [

	^ setupAction
]
