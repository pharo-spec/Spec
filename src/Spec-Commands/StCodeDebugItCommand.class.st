Class {
	#name : #StCodeDebugItCommand,
	#superclass : #StCodeSelectionCommand,
	#category : #'Spec-Commands-Code'
}

{ #category : #activating }
StCodeDebugItCommand class >> contextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 40 for: StCodeContext
]

{ #category : #activating }
StCodeDebugItCommand class >> shortcutActivation [
	<classAnnotation>
	
	^ CmdShortcutActivation 
		by: $d shift meta
		for: StCodeContext
]

{ #category : #accessing }
StCodeDebugItCommand >> defaultMenuItemName [

	^ 'Debug it'
]

{ #category : #execution }
StCodeDebugItCommand >> execute [

	'OK' crLog
]
