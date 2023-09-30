"
A refactor of `TableLayout>>layoutLeftToRight:in:`
"
Class {
	#name : #SpMorphicBoxLayoutCalculatorLeftToRight,
	#superclass : #SpMorphicBoxLayoutCalculator,
	#category : #'Spec2-Adapters-Morphic-Layout'
}

{ #category : #calculating }
SpMorphicBoxLayoutCalculatorLeftToRight >> calculateCellFor: aMorph [
 	| sizeY sizeX props cell minExtent homogeneousWidth |

	props := aMorph layoutProperties ifNil: [ aMorph ].
	props disableTableLayout ifTrue: [ ^ self ].
	
	number := number + 1.
	cell := LayoutCell new target: aMorph.
	
	(props hResizing == #spaceFill) 
		ifTrue:[
			cell hSpaceFill: true.
			extra := aMorph spaceFillWeight.
			cell extraSpace: extra.
			sum := sum + extra ] 
		ifFalse:[
			cell hSpaceFill: false ].
		
	(props vResizing == #spaceFill) ifTrue:[ vFill := true ].
	minExtent := aMorph minExtent.
	homogeneousWidth := aMorph valueOfProperty: #homogeneousWidth.
	homogeneousWidth ifNotNil: [
		minExtent := (minExtent x max: homogeneousWidth)@(minExtent y) ].
	size := minExtent. sizeX := size x. sizeY := size y.
	sizeX < minX
		ifTrue:[ sizeX := minX ]
		ifFalse:[ sizeX > maxX ifTrue: [ sizeX := maxX ] ].
		
	sizeY < minY
		ifTrue:[ sizeY := minY ]
		ifFalse:[ sizeY > maxY ifTrue:[ sizeY := maxY ] ].

	cell cellSize: sizeX.
	lastCell ifNil:[ firstCell := cell ] ifNotNil:[ lastCell nextCell: cell ].
	lastCell := cell.
	width := width + sizeX.
	sizeY > height 
		ifTrue: [ height := sizeY ].
		
	^ sizeX@sizeY
]

{ #category : #calculating }
SpMorphicBoxLayoutCalculatorLeftToRight >> calculateFor: aMorph in: newBounds [
	"An optimized left-to-right list layout"	
	| inset extent posX posY centering extraPerCell cell amount last submorphs |
	
	size := properties minCellSize asPoint. minX := size x. minY := size y.
	size := properties maxCellSize asPoint. maxX := size x. maxY := size y.
	inset := properties cellInset asPoint x.
	extent := newBounds extent.
	number := 0. vFill := false. sum := 0.
	width := height := 0.
	firstCell := lastCell := nil.

	submorphs := aMorph submorphs.
	properties reverseTableCells ifTrue:[ submorphs := submorphs reversed ].
	submorphs do: [ :each | 
		| cellExtent oldExtent |
		oldExtent := each extent.
		cellExtent := each visible 
			ifTrue: [ self calculateCellFor: each ]
			ifFalse: [ 0@0 ].
		"decide if restore or not"
		((oldExtent x = 0) or: [ cellExtent x = 0 ]) ifTrue: [ 
			each privateBounds: (each bounds topLeft extent: cellExtent) ] ].

	number > 1 ifTrue:[ width := width + ((number-1) * inset) ].

	(properties hResizing == #shrinkWrap and: [ properties rubberBandCells or: [ sum isZero ] ])
		ifTrue:[ extent := width @ (extent y max: height) ].
	(properties vResizing == #shrinkWrap and:[ properties rubberBandCells or:[ vFill not ] ])
		ifTrue:[ extent := (extent x max: width) @ height ].

	posX := newBounds left.
	posY := newBounds top.

	"Compute extra vertical space"
	extra := extent y - height.
	extra < 0 ifTrue: [ extra := 0 ].
	extra > 0 ifTrue: [
		vFill 
			ifTrue:[ height := extent y ] 
			ifFalse:[
				centering := properties wrapCentering.
				centering == #bottomRight ifTrue:[ posY := posY + extra ].
				centering == #center ifTrue:[ posY := posY + (extra // 2) ] ] ].

	"Compute extra horizontal space"
	extra := extent x - width.
	extra < 0 ifTrue: [ extra := 0 ].
	extraPerCell := 0.
	extra > 0 
		ifTrue: [
			sum isZero 
				ifTrue: [
				"extra space but no #spaceFillers"
				centering := properties listCentering.
				centering == #bottomRight ifTrue:[ posX := posX + extra ].
				centering == #center ifTrue:[ posX := posX + (extra // 2) ] ] 
			ifFalse:[
				extraPerCell := extra asFloat / sum asFloat ] ].

	number := 0.
	extra := last := 0.
	cell := firstCell.
	[ cell isNil ] whileFalse: [
		number := number + 1.
		width := cell cellSize.
		(extraPerCell > 0 and: [ cell hSpaceFill ]) 
			ifTrue: [
				extra := (last := extra) + (extraPerCell * cell extraSpace).
				amount := extra truncated - last truncated.
				width := width + amount ].
		cell target layoutInBounds: (posX @ posY extent: width @ height).
		posX := posX + width + inset.
		cell := cell nextCell ].

]
