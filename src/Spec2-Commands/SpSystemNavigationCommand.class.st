"
My subclasses implement commands related to system navigation.
"
Class {
	#name : #SpSystemNavigationCommand,
	#superclass : #SpToolCommand,
	#category : #'Spec2-Commands-Navigation'
}

{ #category : #accessing }
SpSystemNavigationCommand >> selector [ 
	^context selectedText asSymbol
]
