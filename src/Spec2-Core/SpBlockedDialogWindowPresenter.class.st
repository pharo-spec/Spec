"
I'm a special dialog presenter used to describe a **blocked** DialogWindow. 
Similar to `SpModalWindowPresenter` I will block the process until to get an answer, but without blocking the background.

Usually instances of `SpBlockedDialogWindowPresenter` are created using the method `SpAbstractPresenter>>#openBlockedDialogWithSpec`.
If you want to make the user to show a dialog without blocking the execution of other windows, use `SpAbstractPresenter>>#openDialogWithSpec` instead.

## Usage 
Typically, you do not instantiate directly a blocked dialog, but you open a presenter as one. Since the program execution will be stopped until dialog is resolved (accepted or cancelled), you can ask for the status after calling it.

```
dialog := aPresenter openBlockedDialogWithSpec.
dialog isOk 
	ifTrue: [ """"dialog accepted action"""" ]
	ifFalse: [ """"dialof cancelled action """" ]
```

And to control how the dialog should behave, you define the method `initializeDialogWindow:` in your presenters.

```
SomePresenter >> initializeDialogWindow: aDialogPresenter 
	super initializeDialogWindow: aDialogPresenter.
	aDialogPresenter
		initialExtent: 600@400;
		title: 'A title';
		closeOnBackdropClick: true
```
"
Class {
	#name : 'SpBlockedDialogWindowPresenter',
	#superclass : 'SpDialogWindowPresenter',
	#category : 'Spec2-Core-Windows',
	#package : 'Spec2-Core',
	#tag : 'Windows'
}

{ #category : 'specs' }
SpBlockedDialogWindowPresenter class >> adapterName [
	^ #BlockedDialogWindowAdapter
]
