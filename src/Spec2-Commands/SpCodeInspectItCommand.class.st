Class {
	#name : #SpCodeInspectItCommand,
	#superclass : #SpCodeSelectionCommand,
	#category : #'Spec2-Commands-Code'
}

{ #category : #activating }
SpCodeInspectItCommand class >> contextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 30 for: SpCodeContext
]

{ #category : #activating }
SpCodeInspectItCommand class >> shortcutActivation [
	<classAnnotation>
	
	^ CmdShortcutActivation 
		by: $i meta
		for: SpCodeContext
]

{ #category : #accessing }
SpCodeInspectItCommand >> defaultMenuItemName [

	^ 'Inspect it'
]

{ #category : #execution }
SpCodeInspectItCommand >> execute [

	'OK' crLog
]
