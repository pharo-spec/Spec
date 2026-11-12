Class {
	#name : 'SpInformDialogTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Dialogs-Tests',
	#package : 'Spec2-Dialogs-Tests'
}

{ #category : 'tests' }
SpInformDialogTest >> testWindowHasTheExtentOfAMessageDialog [
	"SpInformDialog only defined the old #defaultExtent: its window got the preferred extent of any presenter (700@500), too big for a message"

	| window |
	window := (SpInformDialog new
		           message: 'Hello';
		           yourself) asDialogWindow.

	self assert: window initialExtent equals: 450 @ 120
]
