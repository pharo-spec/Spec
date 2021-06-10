Class {
	#name : #SpActivationWrapper,
	#superclass : #Object,
	#instVars : [
		'transformBlock',
		'presenter'
	],
	#category : #'Spec2-Core-Support'
}

{ #category : #accessing }
SpActivationWrapper >> presenter: aPresenter [

	presenter := aPresenter
]

{ #category : #accessing }
SpActivationWrapper >> transform: aBlock [

	transformBlock := aBlock
]

{ #category : #'api - events' }
SpActivationWrapper >> whenActivatedDo: aBlock [

	presenter whenActivatedDo: aBlock
]
