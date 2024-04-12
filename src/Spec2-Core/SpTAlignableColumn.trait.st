Trait {
	#name : 'SpTAlignableColumn',
	#instVars : [
		'alignmentAction'
	],
	#category : 'Spec2-Core-Widgets-Table',
	#package : 'Spec2-Core',
	#tag : 'Widgets-Table'
}

{ #category : 'api' }
SpTAlignableColumn >> displayAlignment [
	"aBlock must return an instance of `SpColumnAlignment`"

	^ alignmentAction
]

{ #category : 'api' }
SpTAlignableColumn >> displayAlignment: aBlock [
	"aBlock must return an instance of `SpColumnAlignment`"

	alignmentAction := aBlock
]
