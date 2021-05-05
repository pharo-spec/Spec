Class {
	#name : #SpActivationTransform,
	#superclass : #Object,
	#instVars : [
		'block',
		'transformBlock'
	],
	#category : #'Spec2-Core-Support'
}

{ #category : #'instance creation' }
SpActivationTransform class >> activateDo: aBlock transform: transformBlock [

	^ self new
		block: aBlock;
		transformBlock: transformBlock;
		yourself
]

{ #category : #accessing }
SpActivationTransform >> block: aBlock [

	block := aBlock
]

{ #category : #evaluating }
SpActivationTransform >> cull: aSelection [

	^ block cull: (SpActivatedSelection new 
		value: (transformBlock value: aSelection);
		yourself).
]

{ #category : #accessing }
SpActivationTransform >> transformBlock: aBlock [

	transformBlock := aBlock
]

{ #category : #evaluating }
SpActivationTransform >> value: aSelection [

	^ self cull: aSelection
]
