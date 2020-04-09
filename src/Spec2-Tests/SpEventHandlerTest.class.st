Class {
	#name : #SpEventHandlerTest,
	#superclass : #TestCase,
	#instVars : [
		'presenter'
	],
	#category : #'Spec2-Tests-Core-Base'
}

{ #category : #running }
SpEventHandlerTest >> tearDown [

	presenter ifNil: [ ^ self ].
	presenter withWindowDo: [ :w | w close ].
	presenter := nil
]

{ #category : #tests }
SpEventHandlerTest >> testEventIsInstalledDynamically [
	| t1 t2 lost got |

	(presenter := SpPresenter new) 
		layout: (SpBoxLayout newVertical
			add: (t1 := presenter newTextInput);
			add: (t2 := presenter newTextInput);
			yourself).

	presenter openWithSpec.

	got := lost := false.
	t1 eventHandler 
		whenGotFocusDo: [ got := true ];
		whenLostFocusDo: [ lost := true ].
	
	t1 takeKeyboardFocus.
	t2 takeKeyboardFocus.
	
	self assert: got.
	self assert: lost
]

{ #category : #tests }
SpEventHandlerTest >> testEventIsInstalledOnBuild [
	| t1 t2 lost got |

	(presenter := SpPresenter new) 
		layout: (SpBoxLayout newVertical
			add: (t1 := presenter newTextInput);
			add: (t2 := presenter newTextInput);
			yourself).

	got := lost := false.
	t1 eventHandler 
		whenGotFocusDo: [ got := true ];
		whenLostFocusDo: [ lost := true ].
		
	presenter openWithSpec.
	
	t1 takeKeyboardFocus.
	t2 takeKeyboardFocus.
	
	self assert: got.
	self assert: lost
]
