Class {
	#name : 'SpToggleMenuItemMorph',
	#superclass : 'ToggleMenuItemMorph',
	#category : 'Spec2-Adapters-Morphic-Support',
	#package : 'Spec2-Adapters-Morphic',
	#tag : 'Support'
}

{ #category : 'private - drawing' }
SpToggleMenuItemMorph >> itemShortcut [

	"In Spec, this is always already normalised"
	^ (ToggleMenuItemShortcut owner: self keyText: '') 
		normalizedKeyText: self keyText;
		yourself
]
