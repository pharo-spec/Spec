Class {
	#name : #SpMorphicBoxLayoutTest,
	#superclass : #TestCase,
	#instVars : [
		'instance'
	],
	#category : #'Spec2-Morphic-Backend-Tests'
}

{ #category : #running }
SpMorphicBoxLayoutTest >> tearDown [

	instance ifNotNil: [ 
		instance close.
		instance := nil ]
]

{ #category : #tests }
SpMorphicBoxLayoutTest >> testClassIsDisplayedWithCorrectAlignment [
	| presenter table |

	presenter := SpBoxLayoutWithTableForTestPresenter new.
	instance := presenter openWithSpec.

	table := presenter table adapter widget.
	self assert: instance window left <= table left.
	self assert: table left <= table submorphs first left
]
