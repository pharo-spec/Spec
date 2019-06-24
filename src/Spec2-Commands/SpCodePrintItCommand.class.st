Class {
	#name : #SpCodePrintItCommand,
	#superclass : #SpCodeSelectionCommand,
	#category : #'Spec2-Commands-Code'
}

{ #category : #activating }
SpCodePrintItCommand class >> contextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 10 for: SpCodeContext
]

{ #category : #activating }
SpCodePrintItCommand class >> shortcutActivation [
	<classAnnotation>
	
	^ CmdShortcutActivation 
		by: $p meta
		for: SpCodeContext
]

{ #category : #accessing }
SpCodePrintItCommand >> defaultMenuItemName [

	^ 'Print it'
]

{ #category : #execution }
SpCodePrintItCommand >> execute [

	'OK' crLog
]
