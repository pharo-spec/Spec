Extension { #name : 'SequenceableCollection' }

{ #category : '*Spec2-Code-Diff' }
SequenceableCollection >> zAt: index [

	^ self at: index + 1
]

{ #category : '*Spec2-Code-Diff' }
SequenceableCollection >> zAt: index put: anObject [

	^ self at: index + 1 put: anObject
]

{ #category : '*Spec2-Code-Diff' }
SequenceableCollection >> zCopyFrom: start to: stop [

	start >= stop ifTrue: [ ^ self species new: 0 ].
	^ self copyFrom: start + 1 to: stop
]
