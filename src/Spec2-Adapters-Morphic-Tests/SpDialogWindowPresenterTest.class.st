Class {
	#name : 'SpDialogWindowPresenterTest',
	#superclass : 'TestCase',
	#instVars : [
		'spec'
	],
	#category : 'Spec2-Adapters-Morphic-Tests',
	#package : 'Spec2-Adapters-Morphic-Tests'
}

{ #category : 'running' }
SpDialogWindowPresenterTest >> setUp [
	super setUp.

	spec := SpDialogWindowPresenter new.
	spec presenter: ((SpPresenter newApplication: SpApplication new) newLabel label: '123')
]

{ #category : 'running' }
SpDialogWindowPresenterTest >> tearDown [
	

	spec close.
	spec := nil.
	super tearDown
	

]

{ #category : 'tests' }
SpDialogWindowPresenterTest >> testCloseBoxCancelsDialog [

	| window |
	spec whenOpenedDo: [
		spec beOk.
		spec withAdapterDo: [ :anAdapter |
			window := anAdapter widget.
			window closeBoxHit ] ].
	spec open.
	self assert: spec isCancelled.
	self deny: window isInWorld
]

{ #category : 'tests' }
SpDialogWindowPresenterTest >> testDialogHasCloseBox [

	| hasCloseBox |
	spec whenOpenedDo: [
		spec withAdapterDo: [ :anAdapter | hasCloseBox := anAdapter widget hasCloseBox ].
		spec close ].
	spec open.
	self assert: hasCloseBox
]

{ #category : 'tests' }
SpDialogWindowPresenterTest >> testWhenResizingDo [

	| resizingEventWasActivated |
	resizingEventWasActivated := false.
	spec := SpDialogWindowPresenter new.
	spec presenter:((SpPresenter newApplication: SpApplication new) newLabel).
	spec initialExtent: 10 @ 10.
	spec
		whenResizingDo: [ resizingEventWasActivated := true ];
		whenOpenedDo: [
				spec withAdapterDo: [ :anAdapter |
						anAdapter widget extent: 15 @ 15 ].
				spec
					beOk;
					close ].
	spec open.
	self assert: resizingEventWasActivated
]

{ #category : 'tests' }
SpDialogWindowPresenterTest >> testWhenWillCloseDo [

	| willCloseEventWasActivated |
	
	willCloseEventWasActivated := false.
	spec
		whenWillCloseDo: [ willCloseEventWasActivated := true ];
		whenOpenedDo: [ 
			spec beOk; close ];
		open.
	self assert: willCloseEventWasActivated
	

]
