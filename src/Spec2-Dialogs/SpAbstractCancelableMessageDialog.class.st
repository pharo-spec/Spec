"
I am the abstract class that holds the common state and behavior of all the MessageDialogs that can have cancel button.
"
Class {
	#name : 'SpAbstractCancelableMessageDialog',
	#superclass : 'SpAbstractMessageDialog',
	#instVars : [
		'cancelLabel'
	],
	#category : 'Spec2-Dialogs',
	#package : 'Spec2-Dialogs'
}

{ #category : 'initialization' }
SpAbstractCancelableMessageDialog >> addButtonsTo: aDialogWindowPresenter [

	aDialogWindowPresenter 
		addButton: self cancelLabel do: [ :presenter | self cancel ].

	super addButtonsTo: aDialogWindowPresenter
]

{ #category : 'api' }
SpAbstractCancelableMessageDialog >> cancelLabel [

	^ cancelLabel ifNil: [ self class defaultCancelLabel ]
]

{ #category : 'api' }
SpAbstractCancelableMessageDialog >> cancelLabel: aString [

	cancelLabel := aString
]
