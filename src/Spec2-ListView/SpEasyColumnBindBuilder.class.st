Class {
	#name : 'SpEasyColumnBindBuilder',
	#superclass : 'SpEasyColumnVisitor',
	#instVars : [
		'item'
	],
	#category : 'Spec2-ListView-Easy',
	#package : 'Spec2-ListView',
	#tag : 'Easy'
}

{ #category : 'visiting' }
SpEasyColumnBindBuilder >> visitCheckboxColumn: aColumn [

	self presenter
		state: (aColumn readObject: self item);
		whenActivatedDo: [ aColumn onActivation value: self item ];
		whenDeactivatedDo: [ aColumn onDeactivation value: self item ]
]
