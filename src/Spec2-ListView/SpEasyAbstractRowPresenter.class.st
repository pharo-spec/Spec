Class {
	#name : 'SpEasyAbstractRowPresenter',
	#superclass : 'SpPresenter',
	#traits : 'SpTModel',
	#classTraits : 'SpTModel classTrait',
	#instVars : [
		'listView'
	],
	#category : 'Spec2-ListView',
	#package : 'Spec2-ListView'
}

{ #category : 'accessing' }
SpEasyAbstractRowPresenter >> listView [

	^ listView
]

{ #category : 'accessing' }
SpEasyAbstractRowPresenter >> listView: aListView [

	listView := aListView
]
