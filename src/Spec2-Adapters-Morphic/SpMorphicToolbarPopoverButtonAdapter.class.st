Class {
	#name : #SpMorphicToolbarPopoverButtonAdapter,
	#superclass : #SpMorphicToolbarButtonAdapter,
	#category : #'Spec2-Adapters-Morphic-Base'
}

{ #category : #execution }
SpMorphicToolbarPopoverButtonAdapter >> execute [

	self presenter newPopover
		addStyle: 'popover-toolbar';
		presenter: self presenter content value;
		popup
]
