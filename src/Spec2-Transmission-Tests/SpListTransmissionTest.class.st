Class {
	#name : #SpListTransmissionTest,
	#superclass : #TestCase,
	#category : #'Spec2-Transmission-Tests'
}

{ #category : #tests }
SpListTransmissionTest >> testSelectionIsNilAfterItemsAssignment [
	| presenter |
	presenter := SpTransmissionTestPresenter new.
	presenter selectIndex: 2.

	presenter items: #(5 6).

	self assert: presenter label equals: 'nil'
]

{ #category : #tests }
SpListTransmissionTest >> testTransmissionIsDoneWhenSelectingAnItem [
	| presenter |
	presenter := SpTransmissionTestPresenter new.

	presenter selectIndex: 2.

	self assert: presenter label equals: '2'
]

{ #category : #tests }
SpListTransmissionTest >> testTransmitNilWhenUnselecteAllItems [
	| presenter |
	presenter := SpTransmissionTestPresenter new.
	presenter selectIndex: 2.

	presenter unselectAll.

	self assert: presenter label equals: 'nil'
]
