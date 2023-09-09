Class {
	#name : #SpNotificationCenterPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'itemList',
		'descriptionText'
	],
	#category : #'Spec2-Dialogs'
}

{ #category : #examples }
SpNotificationCenterPresenter class >> example2 [
	<example>
	
	| app notificationPresenter |
	app := SpApplication new. 
	notificationPresenter := self newApplication: app model: app notificationCenter.
	notificationPresenter open.
	^ app inspect
	
	"1 to: 10 do: [ :each | app notify: each printString ]"
]

{ #category : #initialization }
SpNotificationCenterPresenter >> connectPresenters [

	"Why this is not working 
	itemList whenSelectedItemChangedDo: [ :each | descriptionText text: each text]."
	
	itemList whenSelectedItemChangedDo: [ :each | each ifNotNil: [descriptionText text: each text]]
	
]

{ #category : #initialization }
SpNotificationCenterPresenter >> defaultLayout [
	 
	^ SpBoxLayout newTopToBottom
		add: itemList;
		add: descriptionText;
      yourself
]

{ #category : #initialization }
SpNotificationCenterPresenter >> initializePresenters [

	itemList := self newList.
	itemList display: [ :each | each text contractTo: 20 ]
]

{ #category : #initialization }
SpNotificationCenterPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter title: 'Notifications'
]

{ #category : #initialization }
SpNotificationCenterPresenter >> modelChanged [

	 itemList items: announcingObject value items
]

{ #category : #initialization }
SpNotificationCenterPresenter >> updatePresenter [

	itemList items: announcingObject value items
]
