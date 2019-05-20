Class {
	#name : #StCodePrintItCommand,
	#superclass : #StCodeSelectionCommand,
	#category : #'Spec-Commands-Code'
}

{ #category : #activating }
StCodePrintItCommand class >> contextMenuActivation [
	<classAnnotation>
	
	^ CmdContextMenuActivation byRootGroupItemOrder: 10 for: StCodeContext
]

{ #category : #activating }
StCodePrintItCommand class >> shortcutActivation [
	<classAnnotation>
	
	^ CmdShortcutActivation 
		by: $p meta
		for: StCodeContext
]

{ #category : #accessing }
StCodePrintItCommand >> defaultMenuItemName [

	^ 'Print it'
]

{ #category : #execution }
StCodePrintItCommand >> execute [

	'OK' crLog
]
