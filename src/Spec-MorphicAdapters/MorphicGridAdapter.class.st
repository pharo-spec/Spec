Class {
	#name : #MorphicGridAdapter,
	#superclass : #MorphicLayoutAdapter,
	#category : #'Spec-MorphicAdapters-Layout'
}

{ #category : #private }
MorphicGridAdapter >> addConstraits: constraints toChild: childMorph [
	"adds constraits by child"
	
	childMorph layoutProperties: (GridLayoutProperties new 
		position: constraints position;
		span: constraints span;
		yourself).
	
	^ childMorph
]

{ #category : #private }
MorphicGridAdapter >> basicAdd: aPresenter constaints: constraints to: aPanel [
	| childMorph |

	childMorph := self 
		addConstraits: constraints 
		toChild: (aPresenter buildWithSpec: constraints spec).
	aPanel addMorphBack: childMorph.
		
	^ childMorph	
]

{ #category : #factory }
MorphicGridAdapter >> layout: aLayout [

	"build of widget was differed up to here (to know what is the direction)"
	widget := self newPanel.
	widget layoutPolicy
		padding: aLayout borderWidth;
		rowSpacing: aLayout rowSpacing;
		columnSpacing: aLayout columnSpacing;
		rowHomogeneous: aLayout isRowHomogeneous;
		columnHomogeneous: aLayout isColumnHomogeneous
]

{ #category : #factory }
MorphicGridAdapter >> newPanel [

	^ PanelMorph new 
		layoutPolicy: GridLayout new;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		color: Color transparent;
		yourself
]
