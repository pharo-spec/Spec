Class {
	#name : #StCodeProfileItCommand,
	#superclass : #StCodeSelectionCommand,
	#category : #'Spec-Commands-Code'
}

{ #category : #activating }
StCodeProfileItCommand class >> contextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 50 for: StCodeContext
]

{ #category : #accessing }
StCodeProfileItCommand >> defaultMenuItemName [

	^ 'Profile it'
]

{ #category : #execution }
StCodeProfileItCommand >> execute [

	'OK' crLog
]
