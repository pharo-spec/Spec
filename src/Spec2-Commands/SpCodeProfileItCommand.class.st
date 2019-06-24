Class {
	#name : #SpCodeProfileItCommand,
	#superclass : #SpCodeSelectionCommand,
	#category : #'Spec2-Commands-Code'
}

{ #category : #activating }
SpCodeProfileItCommand class >> contextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 50 for: SpCodeContext
]

{ #category : #accessing }
SpCodeProfileItCommand >> defaultMenuItemName [

	^ 'Profile it'
]

{ #category : #execution }
SpCodeProfileItCommand >> execute [

	'OK' crLog
]
