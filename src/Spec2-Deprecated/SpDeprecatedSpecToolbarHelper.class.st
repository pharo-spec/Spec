"
Description
--------------------

I am a class only here to help to migrate from Spec-Pharo70 to Spec-Pharo80.

I will catch methods from the old dialog toolbar implementation and use the new API.
"
Class {
	#name : #SpDeprecatedSpecToolbarHelper,
	#superclass : #Object,
	#instVars : [
		'windowPresenter'
	],
	#category : #'Spec2-Deprecated-Obsolete'
}

{ #category : #'Spec2-Deprecated' }
SpDeprecatedSpecToolbarHelper class >> for: aWindowPresenter [
	^ self new
		windowPresenter: aWindowPresenter;
		yourself
]

{ #category : #'Spec2-Deprecated' }
SpDeprecatedSpecToolbarHelper class >> isDeprecated [
	^ true
]

{ #category : #'Spec2-Deprecated' }
SpDeprecatedSpecToolbarHelper >> cancelButton [
	^ windowPresenter
		addButton: 'Cancel'
		do: [ :presenter | 
			presenter triggerCancelAction.
			presenter close ]
]

{ #category : #'Spec2-Deprecated' }
SpDeprecatedSpecToolbarHelper >> okButton [
	^ windowPresenter
		addButton: 'Ok'
		do: [ :presenter | 
			presenter triggerOkAction.
			presenter close ]
]

{ #category : #'Spec2-Deprecated' }
SpDeprecatedSpecToolbarHelper >> windowPresenter: aDialogWindowPresenter [ 
	windowPresenter := aDialogWindowPresenter
]
