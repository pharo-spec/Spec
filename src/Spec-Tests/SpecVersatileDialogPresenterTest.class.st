Class {
	#name : #SpecVersatileDialogPresenterTest,
	#superclass : #SpecSmokeTestCase,
	#category : #'Spec-Tests-Core-Widgets'
}

{ #category : #running }
SpecVersatileDialogPresenterTest >> classToTest [
	^ SpecVersatileDialogPresenter
]

{ #category : #tests }
SpecVersatileDialogPresenterTest >> testResult [ 

	| dialog app |
	
	app := MockApplication new.
	
	dialog := SpecVersatileDialogPresenter new.
	dialog application: app.
	dialog title: 'Confirmation'.
	dialog mainMessage: 'Save content' asText allBold.
	dialog addButton: #save text: 'Save' value: true.
	dialog addButton: #cancel text: 'Cancel' value: false.
	dialog mainIcon: (self iconNamed: #question).
	dialog moreOptionsArea: (dialog newCheckBox label: 'Save header').

	dialog openWithSpec. 
	(dialog buttons at: #save) performAction.
	dialog moreOptionsArea click.

	self assert: dialog result.	
	self assert: dialog moreOptionsArea state.
]
