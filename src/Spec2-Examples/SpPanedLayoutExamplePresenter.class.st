"
I am an interactive demo presenter showcasing SpPanedLayout capabilities.

I provide controls to switch between fixed-start (+200 px), fixed-end (-200 px), and proportional (30%, -30%) modes, demonstrating window resizing and splitter dragging behavior.
"
Class {
	#name : 'SpPanedLayoutExamplePresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'textPresenter',
		'listPresenter',
		'modeLabel',
		'btnPropStart',
		'btnPropEnd',
		'btnFixStart',
		'btnFixEnd'
	],
	#category : 'Spec2-Examples-Demo-Layouts',
	#package : 'Spec2-Examples',
	#tag : 'Demo-Layouts'
}

{ #category : 'actions' }
SpPanedLayoutExamplePresenter >> applyLayout: aPosition label: aDescription [
	modeLabel label: 'Current mode: ', aDescription.
	self layout: (SpBoxLayout newTopToBottom
		add: (SpBoxLayout newLeftToRight
			add: btnFixStart;
			add: btnFixEnd;
			add: btnPropStart;
			add: btnPropEnd;
			yourself) expand: false;
		add: modeLabel expand: false;
		add: (SpPanedLayout newLeftToRight
			positionOfSlider: aPosition;
			add: listPresenter;
			add: textPresenter;
			yourself);
		yourself)
]

{ #category : 'layout' }
SpPanedLayoutExamplePresenter >> defaultLayout [
	^ SpBoxLayout newTopToBottom
]

{ #category : 'initialization' }
SpPanedLayoutExamplePresenter >> initializePresenters [
	textPresenter := self newText
		text: 'Resize this window or drag the splitter to observe panel resizing.';
		yourself.
	listPresenter := self newList
		items: (1 to: 100);
		yourself.
	modeLabel := self newLabel.

	btnPropStart := self newButton
		label: '30% Start';
		action: [ self applyLayout: 30 percent label: 'Proportional 30% from start (0.3)' ].
	btnPropEnd := self newButton
		label: '30% End';
		action: [ self applyLayout: -30 percent label: 'Proportional 30% from end (-0.3)' ].
	btnFixStart := self newButton
		label: '200px Start';
		action: [ self applyLayout: 200 label: 'Fixed 200px from start (+200)' ].
	btnFixEnd := self newButton
		label: '200px End';
		action: [ self applyLayout: -200 label: 'Fixed 200px from end (-200)' ].

	self applyLayout: 200 label: 'Fixed 200px from start (+200)'.
]
