Class {
	#name : 'SpToggleSplitPresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'presenter'
	],
	#category : 'Spec2-Tests-Common-Widgets',
	#package : 'Spec2-Tests',
	#tag : 'Common-Widgets'
}

{ #category : 'running' }
SpToggleSplitPresenterTest >> setUp [
	
	super setUp.
	presenter := SpToggleSplitPresenter new.
]

{ #category : 'running' }
SpToggleSplitPresenterTest >> tearDown [

	presenter delete.
	super tearDown.
]

{ #category : 'tests' }
SpToggleSplitPresenterTest >> testOpenHiddenDoesNotDisplayHiddenPresenter [

	presenter 
		first: (SpTextPresenter new text: String loremIpsum) label: 'Show' ;
		second: (SpTextPresenter new text: String loremIpsum) label: 'Hide';
		setHiddenInitialState;
		open.
	self assert: presenter first isDisplayed.
	self deny: presenter second isDisplayed.

]

{ #category : 'tests' }
SpToggleSplitPresenterTest >> testOpenSplittedDoesSplitresenter [

	presenter 
		first: (SpTextPresenter new text: String loremIpsum) label: 'Show' ;
		second: (SpTextPresenter new text: String loremIpsum) label: 'Hide';
		setSplittedInitialState;
		open.
	self assert: presenter first isDisplayed.
	self assert: presenter second isDisplayed.

]
