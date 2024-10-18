Class {
	#name : 'SpEasyAbstractRowPresenter',
	#superclass : 'SpPresenter',
	#traits : 'SpTModel',
	#classTraits : 'SpTModel classTrait',
	#instVars : [
		'listView'
	],
	#category : 'Spec2-ListView-Widget',
	#package : 'Spec2-ListView',
	#tag : 'Widget'
}

{ #category : 'accessing' }
SpEasyAbstractRowPresenter >> listView [

	^ listView
]

{ #category : 'accessing' }
SpEasyAbstractRowPresenter >> listView: aListView [

	listView := aListView
]
