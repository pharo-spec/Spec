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
	notificationPresenter := SpNotificationCenterPresenter 
					newApplication: app model: app notificationCenter.
	notificationPresenter open.
	^ app inspect
	
	"1 to: 10 do: [ :each | app notify: each printString ]"
]

{ #category : #initialization }
SpNotificationCenterPresenter >> connectPresenters [

	itemList whenSelectedItemChangedDo: [ :each | descriptionText text: each text]. 
	
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
	descriptionText := self newText
]

{ #category : #initialization }
SpNotificationCenterPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter title: 'Notifications'
]

{ #category : #initialization }
SpNotificationCenterPresenter >> modelChanged [

	 itemList items: announcingObject items
]

{ #category : #initialization }
SpNotificationCenterPresenter >> updatePresenter [

	itemList items: announcingObject value items
]
