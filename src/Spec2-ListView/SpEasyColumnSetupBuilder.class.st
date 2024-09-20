"
Used to create the setup presenter for an ""easy"" column.
"
Class {
	#name : 'SpEasyColumnSetupBuilder',
	#superclass : 'SpEasyColumnVisitor',
	#category : 'Spec2-ListView-Easy',
	#package : 'Spec2-ListView',
	#tag : 'Easy'
}

{ #category : 'visiting' }
SpEasyColumnSetupBuilder >> visitCheckboxColumn: aColumn [

	^ self presenter newSwitch
]
