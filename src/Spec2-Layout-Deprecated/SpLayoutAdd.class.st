"
A SpecLayoutAdd represents the action to add a subwidget into a spec layout
"
Class {
	#name : #SpLayoutAdd,
	#superclass : #SpLayoutSend,
	#instVars : [
		'layoutFrame',
		'subwidget',
		'subwidgetArguments'
	],
	#category : #'Spec2-Layout-Deprecated'
}

{ #category : #'instance creation' }
SpLayoutAdd class >> subwidget: subwidget layoutFrame: aLayoutFrame [

	^ self new
		subwidget: subwidget 
		layoutFrame: aLayoutFrame asSpLayoutFrame; 
		yourself
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> arguments [
	"We store the result because it change the state of the layouts and should be called only one time. I do not like this implementation but we'll clean later if we have time."

	subwidgetArguments ifNil: [ subwidgetArguments := self subwidgetArguments ].
	^ {{subwidgetArguments . #layout: . self generateSpec}}
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> bottomFraction [

	^ layoutFrame bottomFraction
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> bottomFraction: aNumber [

	layoutFrame bottomFraction: aNumber 
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> bottomOffset [

	^ layoutFrame bottomOffset 
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> bottomOffset: aNumber [

	layoutFrame bottomOffset: aNumber
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> fractions [
	^ layoutFrame fractionRectangle
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> generateSpec [
	| str spec |
	str := layoutFrame asArray readStream.	
	
	spec :=  OrderedCollection with: #SpLayoutFrame.
		
	#( leftFraction: topFraction: rightFraction: bottomFraction: leftOffset: topOffset: rightOffset: bottomOffset: ) do: [:sel |
		spec add: sel.
		str next ifNil: [ spec add: 0 ] ifNotNil: [:value | spec add: value ]].
	^ spec asArray
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> initialize [

	super initialize.
	self selector: #add:.
	layoutFrame := SpLayoutFrame identity
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> layoutFrame [

	^ layoutFrame
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> layoutFrame: newFrame [

	layoutFrame := newFrame asSpLayoutFrame
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> leftFraction [

	^ layoutFrame leftFraction 
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> leftFraction: aNumber [

	layoutFrame leftFraction: aNumber

]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> leftOffset [

	^ layoutFrame leftOffset
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> leftOffset: aNumber [

	^ layoutFrame leftOffset: aNumber
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> offsets [
	"to deprecate 
	"
	self flag: #fix.
	^ layoutFrame leftOffset  @ layoutFrame topOffset corner:  layoutFrame rightOffset  @ layoutFrame bottomOffset 
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> rightFraction [

	^ layoutFrame rightFraction
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> rightFraction: aNumber [

	^ layoutFrame rightFraction: aNumber
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> rightOffset [

	^ layoutFrame rightOffset
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> rightOffset: aNumber [

	layoutFrame rightOffset: aNumber
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> subwidget [
	^ subwidget
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> subwidget: anObject [
	subwidget := anObject
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> subwidget: aSpec layoutFrame: aLayoutFrame [
	subwidget := aSpec isSymbol
		ifTrue: [ {#presenter.
			aSpec} ]
		ifFalse: [ aSpec isCollection
				ifTrue: [ aSpec isEmpty
						ifTrue: [ "should raise an error" ]
						ifFalse: [ self flag: #todo.	"In one version of Pharo the #model should disaper. It's just here for retro compatibility"
							(#(#model #presenter) anySatisfy: [ :symbol | aSpec first = symbol ])
								ifTrue: [ aSpec ]
								ifFalse: [ {#presenter} , aSpec ] ] ]
				ifFalse: [ "Not a symbol or a collection. We assume it's an object to add directly (like a morph by example)" aSpec ] ].
	layoutFrame := aLayoutFrame
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> subwidgetArguments [
	^ subwidget asArray
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> topFraction [

	^ layoutFrame topFraction
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> topFraction: aNumber [

	layoutFrame topFraction: aNumber
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> topOffset [

	^ layoutFrame topOffset
]

{ #category : #'Spec2-Deprecated' }
SpLayoutAdd >> topOffset: aNumber [

	layoutFrame topOffset: aNumber
]
