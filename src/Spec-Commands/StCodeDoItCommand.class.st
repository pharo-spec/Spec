Class {
	#name : #StCodeDoItCommand,
	#superclass : #StCodeSelectionCommand,
	#category : #'Spec-Commands-Code'
}

{ #category : #activating }
StCodeDoItCommand class >> contextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 10 for: StCodeContext
]

{ #category : #activating }
StCodeDoItCommand class >> shortcutActivation [
	<classAnnotation>
	
	^ CmdShortcutActivation 
		by: $d meta
		for: StCodeContext
]

{ #category : #accessing }
StCodeDoItCommand >> defaultMenuItemName [

	^ 'Do it'
]

{ #category : #execution }
StCodeDoItCommand >> execute [

	'OK' crLog
]
