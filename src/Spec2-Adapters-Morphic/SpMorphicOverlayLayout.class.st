"
I'm a morphic layout that superposes morphs.
I have a main submorph and an overlay that is drawn on top.
To decide how to lay out each of these submorphs, they need a property named #constraints with a constraint object.
If the constraints object indicates it is an overlay object, it will be rendered on top.
Otherwise, it will be rendered first in the bottom.

Example

p := PanelMorph new
	hResizing: #spaceFill;
	vResizing: #spaceFill;
	layoutPolicy: SpMorphicOverlayLayout new.

mainMorph := Morph new
	hResizing: #spaceFill;
	vResizing: #spaceFill;
	setProperty: #constraints
	toValue: SpOverlayConstraints new.

overlay := Morph new
	hResizing: #spaceFill;
	vResizing: #spaceFill;
	color: Color green;
	setProperty: #constraints
	toValue: (SpOverlayConstraints new beOverlay; yourself);
	yourself.

p
	addMorphBack: overlay;
	addMorphBack: mainMorph.
p openInWindow
"
Class {
	#name : 'SpMorphicOverlayLayout',
	#superclass : 'LayoutPolicy',
	#category : 'Spec2-Adapters-Morphic-Layout',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Layout'
}

{ #category : 'layout' }
SpMorphicOverlayLayout >> calculatePosXOf: extent in: layoutBounds hAlign: hAlign [
	
	(hAlign = SpLayoutWidgetAlignment center)
		ifTrue: [ ^ ((layoutBounds width - extent x) / 2) asInteger ]. 
	(hAlign = SpLayoutWidgetAlignment start)
		ifTrue: [ ^ 0 ]. 
	(hAlign = SpLayoutWidgetAlignment end)
		ifTrue: [ ^ layoutBounds width - extent x ]. 

	self error: 'Should not arrive here'
]

{ #category : 'layout' }
SpMorphicOverlayLayout >> calculatePosYOf: extent in: layoutBounds vAlign: vAlign [
	
	(vAlign = SpLayoutWidgetAlignment center)
		ifTrue: [ ^ ((layoutBounds height - extent y) / 2) asInteger ]. 
	(vAlign = SpLayoutWidgetAlignment start)
		ifTrue: [ ^ 0 ]. 
	(vAlign = SpLayoutWidgetAlignment end)
		ifTrue: [ ^ layoutBounds height - extent y ]. 

	self error: 'Should not arrive here'
]

{ #category : 'layout' }
SpMorphicOverlayLayout >> layout: aMorph in: layoutBounds [

	aMorph submorphsDo: [ :eachMorph | | constraints |
		constraints := eachMorph valueOfProperty: #constraints.
		eachMorph visible 
			ifTrue: [ 
				constraints isOverlay
					ifTrue: [ self layoutOverlay: eachMorph in: layoutBounds ]
					ifFalse: [ eachMorph bounds: layoutBounds ] ]
			ifFalse: [ 
				eachMorph bounds: (0@0 corner: 0@0) ] ]
]

{ #category : 'layout' }
SpMorphicOverlayLayout >> layoutOverlay: overlayMorph in: layoutBounds [
	| constraints newExtent newBounds vAlign hAlign x y w h |
	
	constraints := overlayMorph valueOfProperty: #constraints.

	vAlign := constraints vAlign ifNil: [ SpLayoutWidgetAlignment center ].
	hAlign := constraints hAlign ifNil: [ SpLayoutWidgetAlignment center ].
	w := overlayMorph width.
	h := overlayMorph height.
	newExtent := w @ h.
	x := (self calculatePosXOf: newExtent in: layoutBounds hAlign: hAlign). 
	y := (self calculatePosYOf: newExtent in: layoutBounds vAlign: vAlign). 
	
	newBounds := (layoutBounds origin + (x@y)) extent: newExtent.		
	overlayMorph bounds: newBounds
]
