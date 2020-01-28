"
My subclasses implement commands related to system navigation.
I give a selector from a context that must:
- be a block
- evaluate to a string or symbol
"
Class {
	#name : #SpSystemNavigationCommand,
	#superclass : #SpToolCommand,
	#category : #'Spec2-Commands-Navigation'
}

{ #category : #accessing }
SpSystemNavigationCommand >> selector [ 
	^self context asSymbol
]
