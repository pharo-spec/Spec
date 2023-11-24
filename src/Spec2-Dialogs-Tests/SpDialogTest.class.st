Class {
	#name : 'SpDialogTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Dialogs-Tests',
	#package : 'Spec2-Dialogs-Tests'
}

{ #category : 'tests - informUserDuring' }
SpDialogTest >> testInformUserDuring [

	self shouldnt: [ SpInformUserDialog new informUser: 'hello' during: [  (Delay forMilliseconds: 100)  wait] ] raise: Error
]

{ #category : 'tests - progress bar' }
SpDialogTest >> testInformUserDuringExecutesItsBlock [

	| executed | 
	executed := false. 
	SpInformUserDialog new informUser: 'hello' during: [ executed := true ].
	self assert: executed.
]

{ #category : 'tests - progress bar' }
SpDialogTest >> testInformUserDuringExecutesTheBlockOnlyOnce [

	| count |
	count := 0.
	SpInformUserDialog new 
		informUser: 'I am a text' during: [ count := count + 1 ].
		
	self assert: count equals: 1
]

{ #category : 'tests - progress bar' }
SpDialogTest >> testInformUserDuringInSpApplicationExecutesTheBlockOnlyOnce [

	| count |
	count := 0.
	SpApplication new 
		informUser: 'I am a text' during: [ count := count + 1 ].
		
	self assert: count equals: 1
]

{ #category : 'tests - informUserDuring' }
SpDialogTest >> testInformUserDuringViaApplication [

	self shouldnt: [ SpPresenter new application informUser: 'hello' during: [  (Delay forMilliseconds: 100)  wait] ] raise: Error.
	
]

{ #category : 'tests - informUserDuring' }
SpDialogTest >> testInformUserDuringViaPresenter [

	self shouldnt: [ SpPresenter new informUser: 'hello' during: [  (Delay forMilliseconds: 100)  wait] ] raise: Error.
	self shouldnt: [ SpPresenter new informUser: 'hello' during: [  (Delay forMilliseconds: 100)  wait] ] raise: Error
]

{ #category : 'tests - progress bar' }
SpDialogTest >> testProgressInformUserDuringExecutesItsBlock [

	| executed | 
	executed := false. 
	SpProgressDialog new informUser: 'hello' during: [ executed := true.  ]. 
	self assert: executed.
]
