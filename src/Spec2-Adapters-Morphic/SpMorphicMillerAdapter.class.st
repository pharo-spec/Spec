Class {
	#name : #SpMorphicMillerAdapter,
	#superclass : #SpMorphicLayoutAdapter,
	#instVars : [
		'layout'
	],
	#category : #'Spec2-Adapters-Morphic-Layout'
}

{ #category : #factory }
SpMorphicMillerAdapter >> add: aPresenter [
 
	self add: aPresenter constraints: SpBoxConstraints new
]

{ #category : #private }
SpMorphicMillerAdapter >> addConstraits: constraints toChild: childMorph [
	"adds constraits by child"

	"Set morph to stay rigid"
	layout direction setRigidityOfNonExpandedMorph: childMorph.
	
	^ childMorph
]

{ #category : #private }
SpMorphicMillerAdapter >> addPadding: aNumber toMorph: aMorph [
	
	aNumber = 0 ifTrue: [ ^ aMorph ].
	
	^ layout direction 
		addPadding: aNumber 
		toMorph: aMorph
		into: self
]

{ #category : #private }
SpMorphicMillerAdapter >> basicAdd: aPresenter constraints: constraints to: aPanel [
	| childMorph |

	childMorph := self buildMorph: aPresenter constraints: constraints.	
	aPanel addMorphBack: childMorph.

	^ childMorph
]

{ #category : #accessing }
SpMorphicMillerAdapter >> childrenWidgets [
	
	^ widget submorphs
]

{ #category : #factory }
SpMorphicMillerAdapter >> layout: aLayout [

	layout := aLayout.
	
	widget ifNil: [
		"build of widget was differed up to here (to know what is the direction)"
		widget := aLayout direction newWidgetOn: self.
		widget borderWidth: aLayout borderWidth.
		"the spacing needs to be applied to the inner sub-panels"
		widget submorphs do: [ :each |
			each cellInset: aLayout spacing ] ].
	
	super layout: aLayout
]

{ #category : #factory }
SpMorphicMillerAdapter >> newHorizontal [

	^ self newPanel 
		listDirection: #leftToRight;
		yourself
]

{ #category : #factory }
SpMorphicMillerAdapter >> newPanel [

	^ PanelMorph new 
		changeTableLayout;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		extent: 0@0;
		color: Color transparent;
		borderColor: Color transparent;
		yourself
]

{ #category : #factory }
SpMorphicMillerAdapter >> newVertical [

	^ self newPanel 
		listDirection: #topToBottom;
		yourself
]

{ #category : #accessing }
SpMorphicMillerAdapter >> remove: aPresenter [
	| morph |

	morph := aPresenter adapter widget.	
	widget removeMorph: morph
]

{ #category : #accessing }
SpMorphicMillerAdapter >> removeAll [

	widget removeAllMorphs
]

{ #category : #factory }
SpMorphicMillerAdapter >> removeSubWidgets [

	widget removeAllMorphs
]
