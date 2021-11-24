"
I'm a window presenter used to describe a **modal** DialogWindow. 
On the contrary of the `SpDialogWindowPresenter`, I will block the user to focus any other window.

Usually instances of `SpModalWindowPresenter` are created using the method `SpAbstractPresenter>>#openModalWithSpec`.

If you want to make the user to show a dialog without blocking the execution of other windows, use `SpAbstractPresenter>>#openDialogWithSpec` instead.

## Usage
Typically, you do not instantiate directly a modal dialog, but you open a presenter as one. Since the program execution will be stopped until dialog is resolved (accepted or cancelled), you can ask for the status after calling it.

```
dialog := aPresenter openModalWithSpec.
dialog isOk 
	ifTrue: [ ""dialog accepted action"" ]
	ifFalse: [ ""dialof cancelled action "" ]
```

The method `SpModalWindowPresenter>>#closeOnBackdropClick:` controls whether the user is able to close or not the modal dialog.

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
	#name : #SpModalWindowPresenter,
	#superclass : #SpDialogWindowPresenter,
	#instVars : [
		'#closeOnBackdropClick => ObservableSlot'
	],
	#category : #'Spec2-Core-Windows'
}

{ #category : #specs }
SpModalWindowPresenter class >> adapterName [

	^ #ModalWindowAdapter
]

{ #category : #api }
SpModalWindowPresenter >> closeOnBackdropClick [
	"Answer if the user will be able to click on the backdrop to close the modal 
	 launching the cancel action."
	
	^ closeOnBackdropClick
]

{ #category : #api }
SpModalWindowPresenter >> closeOnBackdropClick: aBoolean [
	"Set when the user will be able to click on the backdrop to close the modal 
	 launching the cancel action."

	closeOnBackdropClick := aBoolean
]

{ #category : #initialization }
SpModalWindowPresenter >> initialize [

	super initialize.
	closeOnBackdropClick := false
]
