Class {
	#name : #SpDialogPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'#parentWindow => WeakSlot'
	],
	#category : #'Spec2-Dialogs'
}

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

{ #category : #initialization }
SpDialogPresenter >> initializeDialogWindow: aDialogWindowPresenter [

	self parentWindow 
		ifNotNil: [ :w | aDialogWindowPresenter centeredRelativeTo: w ] 
		ifNil: [ aDialogWindowPresenter centered ]
]

{ #category : #initialization }
SpDialogPresenter >> initializeWindow: aWindowPresenter [

	self traversePresentersDo: [ :each |
		each addGlobalShortcutsTo: aWindowPresenter ]
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
