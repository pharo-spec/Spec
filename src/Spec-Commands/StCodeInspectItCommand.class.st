Class {
	#name : #StCodeInspectItCommand,
	#superclass : #StCodeSelectionCommand,
	#category : #'Spec-Commands-Code'
}

{ #category : #activating }
StCodeInspectItCommand class >> contextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 30 for: StCodeContext
]

{ #category : #activating }
StCodeInspectItCommand class >> shortcutActivation [
	<classAnnotation>
	
	^ CmdShortcutActivation 
		by: $i meta
		for: StCodeContext
]

{ #category : #accessing }
StCodeInspectItCommand >> defaultMenuItemName [

	^ 'Inspect it'
]

{ #category : #execution }
StCodeInspectItCommand >> execute [

	'OK' crLog
]
