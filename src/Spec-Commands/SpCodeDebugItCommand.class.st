Class {
	#name : #SpCodeDebugItCommand,
	#superclass : #SpCodeSelectionCommand,
	#category : #'Spec-Commands-Code'
}

{ #category : #activating }
SpCodeDebugItCommand class >> contextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 40 for: SpCodeContext
]

{ #category : #activating }
SpCodeDebugItCommand class >> shortcutActivation [
	<classAnnotation>
	
	^ CmdShortcutActivation 
		by: $d shift meta
		for: SpCodeContext
]

{ #category : #accessing }
SpCodeDebugItCommand >> defaultMenuItemName [

	^ 'Debug it'
]

{ #category : #execution }
SpCodeDebugItCommand >> execute [

	'OK' crLog
]
