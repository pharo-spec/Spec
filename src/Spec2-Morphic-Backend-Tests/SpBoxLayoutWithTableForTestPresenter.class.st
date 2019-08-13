Class {
	#name : #SpBoxLayoutWithTableForTestPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'table'
	],
	#category : #'Spec2-Morphic-Backend-Tests'
}

{ #category : #specs }
SpBoxLayoutWithTableForTestPresenter class >> defaultSpec [

	^ SpBoxLayout newVertical
		add: #table;
		yourself
]

{ #category : #'instance creation' }
SpBoxLayoutWithTableForTestPresenter class >> open [ 
	<script>
	
	self new openWithSpec
]

{ #category : #initialization }
SpBoxLayoutWithTableForTestPresenter >> initializeWidgets [
	
	(table := self newTable) 
		items: Smalltalk allClassesAndTraits;
		addColumn: (SpCompositeTableColumn new
			title: 'Test'; 
			addColumn: ((SpImageTableColumn evaluated: [ :each | each systemIcon ]) width: 20);
			addColumn: (SpStringTableColumn evaluated: [ :each | each name ])).
]

{ #category : #'as yet unclassified' }
SpBoxLayoutWithTableForTestPresenter >> table [

	^ table
]
