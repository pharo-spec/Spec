"
I am base for Spec Standard Dialogs.
Standard dialogs are available to provide simple I/O to users.
"
Class {
	#name : #SpDialogPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'#parentWindow => WeakSlot',
		'#acceptAction',
		'#cancelAction'
	],
	#category : #'Spec2-Dialogs'
}

{ #category : #accessing }
SpDialogPresenter class >> defaultAcceptLabel [

	^ 'Accept'
]

{ #category : #accessing }
SpDialogPresenter class >> defaultCancelLabel [

	^ 'Cancel'
]

{ #category : #'instance creation' }
SpDialogPresenter class >> open [
	<script>
	
	^ self new openWithSpec
]

{ #category : #'instance creation' }
SpDialogPresenter class >> openDialog [
	<script>
	
	^ self new openDialogWithSpec
]

{ #category : #private }
SpDialogPresenter >> accept [

	self window 
		beOk; 
		triggerOkAction;
		close
]

{ #category : #private }
SpDialogPresenter >> cancel [

	self window 
		beCancel; 
		triggerCancelAction;
		close
]

{ #category : #initialization }
SpDialogPresenter >> initializeDialogWindow: aDialogWindowPresenter [

	aDialogWindowPresenter 
		okAction: acceptAction;
		cancelAction: cancelAction.
	
	self parentWindow 
		ifNotNil: [ :w | aDialogWindowPresenter centeredRelativeTo: w ] 
		ifNil: [ aDialogWindowPresenter centered ].
]

{ #category : #'api-events' }
SpDialogPresenter >> onAccept: aBlock [

	acceptAction := aBlock
]

{ #category : #'api-events' }
SpDialogPresenter >> onCancel: aBlock [

	cancelAction := aBlock
]

{ #category : #api }
SpDialogPresenter >> openDialogWithSpecParent: aWindow [
	
	parentWindow := aWindow.
	^ self openDialogWithSpec
]

{ #category : #accessing }
SpDialogPresenter >> parentWindow [

	^ parentWindow
]
