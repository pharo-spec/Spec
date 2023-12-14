"
I'm a morphic adapter for a scrollable layout. I contain a main widget that takes as much space as he wants and I add scrolling to it.

Internally, I create a GeneralScrollPane.

When I'm empty, I set the GeneralScrollPane's to an empty panel morph which I keep around to know if I'm empty or not.

## Example

```language=Pharo
| scrollable widgets boxLayout |

boxLayout := SpBoxLayout newVertical.
widgets := (1 to: 100) collect: [ : i | 
	boxLayout add: (SpButtonPresenter new label: i asString; yourself) ].
SpPresenter new
	layout: (scrollable := SpScrollableLayout new
		child:(SpPresenter new
			layout: boxLayout;
			yourself);
		yourself);
	open.
scrollable scrollTo: 0.1 @ 0.2
```
"
Class {
	#name : 'SpMorphicScrollableAdapter',
	#superclass : 'SpMorphicLayoutAdapter',
	#instVars : [
		'emptyLayoutMarker'
	],
	#category : 'Spec2-Adapters-Morphic-Layout',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Layout'
}

{ #category : 'protocol' }
SpMorphicScrollableAdapter >> addConstraints: constraints toChild: childMorph [
	"Adds constraits by child"
	
	| theMorph |	
	theMorph := childMorph.
	"Keep constraints to layout usage"
	theMorph setProperty: #constraints toValue: constraints. 
	
	^ theMorph 
]

{ #category : 'protocol' }
SpMorphicScrollableAdapter >> basicAdd: aPresenter constraints: constraints to: aPanel [

	| childMorph |
	childMorph := self buildMorph: aPresenter constraints: constraints.	
	
	childMorph 
		hResizing: #spaceFill;
		vResizing: #spaceFill.

	aPanel scrollTarget: childMorph.
	
	^ childMorph
]

{ #category : 'test support' }
SpMorphicScrollableAdapter >> childWidget [

	^ self children 
		ifNotEmpty: [ :aCollection | aCollection first ]
		ifEmpty: [ nil ]
]

{ #category : 'accessing' }
SpMorphicScrollableAdapter >> children [

	widget scrollTarget == emptyLayoutMarker
		ifTrue: [ ^ #() ].
	^ { widget scrollTarget }
]

{ #category : 'protocol' }
SpMorphicScrollableAdapter >> layout: aLayout [

	layout := aLayout.
	
	emptyLayoutMarker := PanelMorph new
		                     hResizing: #spaceFill;
		                     vResizing: #spaceFill;
		                     yourself.
	widget ifNil: [ 
		widget := GeneralScrollPaneMorph new
			          changeScrollerTableLayout;
			          hResizing: #spaceFill;
			          vResizing: #spaceFill;
			          color: Color transparent;
			          borderColor: Color transparent;
			          scrollTarget: emptyLayoutMarker;
			          yourself ].

	aLayout whenChildrenAddedDo: [ :ann | 
		self basicAdd: ann child constraints: (aLayout constraintsFor: ann child) to: widget ].

	aLayout whenChildrenRemovedDo: [ :ann | self removeChild: ann child ].

	super layout: aLayout
]

{ #category : 'removing' }
SpMorphicScrollableAdapter >> removeChild: aPresenter [

	self assert: aPresenter adapter widget == widget scrollTarget.
	widget scrollTarget: emptyLayoutMarker
]

{ #category : #accessing }
SpMorphicScrollableAdapter >> scrollTo: aPoint [
	" Scroll the receiver horizontally and vertically determined by aPoint x and y respectively.
	x and y should be in range [0,1] "

	widget
		vScrollbarValue: aPoint x;
		hScrollbarValue: aPoint y;
		updateScrollbars
]
