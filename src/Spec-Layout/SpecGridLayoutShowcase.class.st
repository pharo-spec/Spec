Class {
	#name : #SpecGridLayoutShowcase,
	#superclass : #SpecBaseLayoutShowcase,
	#instVars : [
		'columnHomogeneous',
		'rowHomogeneous',
		'columnSpacing',
		'rowSpacing',
		'borderWidth'
	],
	#category : #'Spec-Layout-Examples'
}

{ #category : #specs }
SpecGridLayoutShowcase class >> defaultSpec [
	<spec: #default>

	^ SpecBoxLayout newVertical
		beHomogeneous;
		add: #displayedLayout;
		add: (SpecGridLayout new
			beColumnHomogeneous;
			add: (SpecLabel label: 'Column homogeneous') at: 1@1;
			add: #columnHomogeneous at: 2@1;
			add: (SpecLabel label: 'Row homogeneous') at: 1@2;
			add: #rowHomogeneous at: 2@2;
			add: (SpecLabel label: 'Column spacing') at: 1@3;
			add: #columnSpacing at: 2@3;
			add: (SpecLabel label: 'Row spacing') at: 1@4;
			add: #rowSpacing at: 2@4;
			add: (SpecLabel label: 'Border width') at: 1@5;
			add: #borderWidth at: 2@5;
			yourself);
		yourself
]

{ #category : #initialization }
SpecGridLayoutShowcase >> initializeLayout [

	layoutSpec := SpecGridLayout new
		add: #presenter1 at: 1@1;
		add: #presenter2 at: 2@1;
		add: #presenter3 at: 1@2;
		add: #presenter4 at: 2@2;
		yourself
]

{ #category : #initialization }
SpecGridLayoutShowcase >> initializeWidgets [
	
	displayedLayout := self newLayout.
	
	columnHomogeneous := self newCheckBox.
	rowHomogeneous := self newCheckBox.
	(columnSpacing := self newNumberInput) 
		number: 0;
		minimum: 0;
		maximum: 100.
	(rowSpacing := self newNumberInput number: 0)
		number: 0;
		minimum: 0;
		maximum: 100.
	(borderWidth := self newNumberInput number: 0)
		number: 0;
		minimum: 0;
		maximum: 100
]
