Class {
	#name : #SpNotificationCenterPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'itemList',
		'descriptionText',
		'clearButton'
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
SpNotificationCenterPresenter >> clearNotificationsAction [

	itemList items: OrderedCollection new.
	descriptionText text: '   No notification   '
]

{ #category : #initialization }
SpNotificationCenterPresenter >> connectPresenters [

	"Why this is not working 
	itemList whenSelectedItemChangedDo: [ :each | descriptionText text: each text]."
	
	itemList whenSelectedDo: [ :each | each ifNotNil: [descriptionText text: each text]]
	
]

{ #category : #layout }
SpNotificationCenterPresenter >> defaultLayout [

	| upperLayout lowerLayout |
	upperLayout := SpBoxLayout newLeftToRight
		addLast: clearButton;
		yourself.
	lowerLayout := SpPanedLayout newTopToBottom
		positionOfSlider: 0.8;
		add: itemList;
		add: descriptionText;
		yourself.
	^ SpBoxLayout newTopToBottom
		  add: upperLayout expand: false;
		  add: lowerLayout;
		  yourself
]

{ #category : #initialization }
SpNotificationCenterPresenter >> initializePresenters [

	itemList := self newList
		display: [ :each | '  ' , each text contractTo: 20 ];
		yourself.
	descriptionText := self newText.
	clearButton := self newButton
		icon: (self iconNamed: #smallUpdate);
		label: 'Clear notifications';
		action: [ self clearNotificationsAction ];
		yourself
]

{ #category : #initialization }
SpNotificationCenterPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter title: 'Notifications'
]

{ #category : #initialization }
SpNotificationCenterPresenter >> modelChanged [
	
	itemList items: announcingObject value items.
	itemList selectFirst
]

{ #category : #updating }
SpNotificationCenterPresenter >> updatePresenter [
	
	self modelChanged
]
