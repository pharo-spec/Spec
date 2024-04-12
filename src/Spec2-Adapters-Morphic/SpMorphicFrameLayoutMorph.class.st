"
I am a supporting morph for the frame layout
"
Class {
	#name : 'SpMorphicFrameLayoutMorph',
	#superclass : 'Morph',
	#instVars : [
		'label'
	],
	#category : 'Spec2-Adapters-Morphic-Support',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Support'
}

{ #category : 'drawing' }
SpMorphicFrameLayoutMorph >> drawOn: aCanvas [

	| frame color1 color2 textFrame labelOffset font labelWidth inset labelSpacing bothSidesLabelSpacing baseColor |
	
	aCanvas fillRectangle: self bounds fillStyle: self fillStyle borderStyle: self borderStyle.
	
	baseColor := self theme baseColor.
	color1 := baseColor adjustBrightness: -0.2.
	color2 := baseColor adjustBrightness: 0.2.
	labelOffset := self headerHeight.
	labelSpacing := self headerHeight // 3.
	inset := self headerHeight // 2.
	
	font := self font.
		
	bothSidesLabelSpacing := labelSpacing * 2.
	
	frame := self frameBounds.
	textFrame := self bounds topLeft + (labelOffset + labelSpacing@0) corner: self bounds bottomRight - (labelOffset + labelSpacing @0).
	
	labelWidth := (font widthOfString: label) min: textFrame width.
	
	
	aCanvas line: frame topLeft to: frame bottomLeft - (0@1) width: 1 color: color1.
	aCanvas line: frame bottomLeft - (0@1) to: frame bottomRight - (1@1) width: 1 color: color1.
	aCanvas line: frame bottomRight - (1@1) to: frame topRight - (1@0) color: color1.

	aCanvas line: frame topRight - (1@0) to: frame topLeft + (labelOffset - inset + bothSidesLabelSpacing + labelWidth @ 0) color: color1.
	aCanvas line: frame topLeft to: frame topLeft + (labelOffset - inset @ 0) color: color1.

	aCanvas line: frame topLeft + (1@1) to: frame bottomLeft + (1@(-2)) width: 1 color: color2.
	aCanvas line: frame bottomLeft to: frame bottomRight width: 1 color: color2.
	aCanvas line: frame bottomRight to: frame topRight color: color2.
		
	aCanvas line: frame topRight + (-2@1) to: frame topLeft + (labelOffset - inset + bothSidesLabelSpacing + labelWidth @ 1)  color: color2.	
	aCanvas line: frame topLeft + (1@1) to: frame topLeft + (labelOffset - inset @ 1)  color: color2.	
	
	aCanvas
			drawString: label
			in: textFrame
			font: font
			color: self theme textColor.
]

{ #category : 'accessing' }
SpMorphicFrameLayoutMorph >> font [ 

	^ TextStyle defaultFont.
	
]

{ #category : 'drawing' }
SpMorphicFrameLayoutMorph >> frameBounds [

	| aBorderWidth theBounds topInset |
	
	topInset := self headerHeight // 2.
	
	aBorderWidth := self borderWidth // 2.
	theBounds := self bounds.
	
	^ (theBounds topLeft + (aBorderWidth @ topInset)) corner: (theBounds bottomRight - (aBorderWidth @ aBorderWidth)) 
]

{ #category : 'accessing' }
SpMorphicFrameLayoutMorph >> headerHeight [ 

	^ self font height ceiling max: self borderWidth.

]

{ #category : 'drawing' }
SpMorphicFrameLayoutMorph >> innerBounds [

	| aBorderWidth theBounds |
	
	aBorderWidth := self borderWidth.
	theBounds := self bounds.
	
	^ (theBounds topLeft + (aBorderWidth @ self headerHeight)) corner: (theBounds bottomRight - (aBorderWidth @ aBorderWidth)) 
]

{ #category : 'accessing' }
SpMorphicFrameLayoutMorph >> label [

	^ label
]

{ #category : 'accessing' }
SpMorphicFrameLayoutMorph >> label: anObject [

	label := anObject
]

{ #category : 'drawing' }
SpMorphicFrameLayoutMorph >> labelSpacing [ 

	^ self headerHeight // 3.

]
