Class {
	#name : #MorphicMenuBarAdapter,
	#superclass : #MorphicBaseMenuAdapter,
	#category : #'Spec-MorphicAdapters-Base'
}

{ #category : #private }
MorphicMenuBarAdapter >> buildWidget [

	^ ToolDockingBarMorph new
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		adoptMenuModel: self model
		yourself
]
