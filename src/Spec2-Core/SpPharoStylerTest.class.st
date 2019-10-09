Class {
	#name : #SpPharoStylerTest,
	#superclass : #TestCase,
	#category : #'Spec2-Core-Widgets-Text'
}

{ #category : #tests }
SpPharoStylerTest >> testApplyStyleTo [
	| text |

	text := SpPharoStyler new applyStyleTo: '42 factorial' asText.
	self assert: text class equals: Text
]
