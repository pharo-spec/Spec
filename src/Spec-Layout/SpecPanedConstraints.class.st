Class {
	#name : #SpecPanedConstraints,
	#superclass : #Object,
	#instVars : [
		'resize',
		'shrink'
	],
	#category : #'Spec-Layout-Box'
}

{ #category : #'as yet unclassified' }
SpecPanedConstraints class >> defaultExpand [

	^ true
]

{ #category : #'as yet unclassified' }
SpecPanedConstraints class >> defaultFill [

	^ true
]

{ #category : #'as yet unclassified' }
SpecPanedConstraints class >> defaultPadding [ 

	^ 0
]

{ #category : #accessing }
SpecPanedConstraints >> beNotResizeable [

	resize := false
]

{ #category : #accessing }
SpecPanedConstraints >> beNotShrinkeable [

	shrink := false
]

{ #category : #accessing }
SpecPanedConstraints >> beResizeable [

	resize := true
]

{ #category : #accessing }
SpecPanedConstraints >> beShrinkeable [

	shrink := true
]

{ #category : #testing }
SpecPanedConstraints >> canResize [

	^ resize
]

{ #category : #testing }
SpecPanedConstraints >> canShrink [

	^ shrink
]

{ #category : #initialization }
SpecPanedConstraints >> initialize [ 

	super initialize.
	self canResize.
	self canShrink.
]
