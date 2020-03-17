"
A SpecLayoutAddWithSpec is an action representing an add in the spec layout with a spec selector precised
"
Class {
	#name : #SpLayoutAddWithSpec,
	#superclass : #SpLayoutAdd,
	#instVars : [
		'specSelector'
	],
	#category : #'Spec2-Layout-Deprecated'
}

{ #category : #'instance creation' }
SpLayoutAddWithSpec class >> subwidget: subwidget spec: aSpecSelector layoutFrame: aLayoutFrame [

	^ self new
		subwidget: subwidget 
		spec: aSpecSelector 
		layoutFrame:  aLayoutFrame;
		yourself
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAddWithSpec >> specSelector [
	^ specSelector
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAddWithSpec >> specSelector: aSymbol [
	specSelector := aSymbol
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAddWithSpec >> subwidget: sub spec: aSpecSelector layoutFrame: aFrameLayout [
	self subwidget: sub.
	self specSelector: aSpecSelector.
	self layoutFrame: aFrameLayout
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAddWithSpec >> subwidgetArguments [
	^ self subwidget isArray
		ifTrue: [ #(presenter) , self subwidget , {#retrieveSpec:. self specSelector} ]
		ifFalse: [ {#presenter. self subwidget. #retrieveSpec:. self specSelector} ]
]
