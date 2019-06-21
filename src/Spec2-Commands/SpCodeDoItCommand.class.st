Class {
	#name : #SpCodeDoItCommand,
	#superclass : #SpCodeSelectionCommand,
	#category : #'Spec2-Commands-Code'
}

{ #category : #activating }
SpCodeDoItCommand class >> contextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 10 for: SpCodeContext
]

{ #category : #activating }
SpCodeDoItCommand class >> shortcutActivation [
	<classAnnotation>
	
	^ CmdShortcutActivation 
		by: $d meta
		for: SpCodeContext
]

{ #category : #accessing }
SpCodeDoItCommand >> defaultMenuItemName [

	^ 'Do it'
]

{ #category : #execution }
SpCodeDoItCommand >> execute [

	'OK' crLog
]
