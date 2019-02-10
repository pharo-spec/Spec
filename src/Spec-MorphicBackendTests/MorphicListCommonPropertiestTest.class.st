Class {
	#name : #MorphicListCommonPropertiestTest,
	#superclass : #MorphicAdapterTestCase,
	#category : #'Spec-MorphicBackendTests'
}

{ #category : #running }
MorphicListCommonPropertiestTest >> classToTest [
	^ ListPresenter
]

{ #category : #running }
MorphicListCommonPropertiestTest >> setUp [

	super setUp.

	window := presenter
		items: #(10 20 30);
		openWithSpec.
]

{ #category : #running }
MorphicListCommonPropertiestTest >> testSetColumnTitleInPresenterShowsThemInWidget [

	self presenter headerTitle: 'test'.
	
	self assert: self widget isShowColumnHeaders
]
