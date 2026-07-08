"
A SpStringTableColumnTest is a test class for testing the behavior of SpStringTableColumn
"
Class {
	#name : 'SpStringTableColumnTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Tests-Core-Widgets',
	#package : 'Spec2-Tests',
	#tag : 'Core-Widgets'
}

{ #category : 'tests' }
SpStringTableColumnTest >> testDisplayObjectRespectsFormatting [

	| column dateToShow |
	column := SpStringTableColumn new.
	column formatted: [ :e | e displayString ].

	dateToShow := Date today.

	self
		assert: (column readObject: dateToShow)
		equals: dateToShow displayString
]

{ #category : 'tests' }
SpStringTableColumnTest >> testDisplayObjectWithoutFormattingReturnsTheObjectItself [

	| column dateToShow |
	column := SpStringTableColumn new.

	dateToShow := Date today.

	"It's up to the table to stringify the object later"
	self
		assert: (column readObject: dateToShow)
		equals: dateToShow
]

{ #category : 'tests' }
SpStringTableColumnTest >> testIsSortable [
	|widget|
	
	widget := SpStringTableColumn new.
	self assert: widget isSortable.
	widget sortFunction: [:a :b|].
	self assert: widget isSortable.
	widget sortFunction: nil.
	self deny: widget isSortable
]
