"
Display the toolbar with labels only
"
Class {
	#name : 'SpLabelToolbarDisplayMode',
	#superclass : 'SpToolbarDisplayMode',
	#category : 'Spec2-Core-Widgets',
	#package : 'Spec2-Core',
	#tag : 'Widgets'
}

{ #category : 'configuring' }
SpLabelToolbarDisplayMode >> configureButton: aButton item: aToolbarItem [
	"ask for label (no icon)"
	aButton getLabelSelector: #label.
	aButton badgeSelector: #badge.
	aButton getStateSelector: #state	
]

{ #category : 'accessing' }
SpLabelToolbarDisplayMode >> extent [
	^ (45@25) scaledByDisplayScaleFactor
]

{ #category : 'testing' }
SpLabelToolbarDisplayMode >> hasLabel [

	^ true
]

{ #category : 'accessing' }
SpLabelToolbarDisplayMode >> label [

	^ 'Label'
]

{ #category : 'accessing' }
SpLabelToolbarDisplayMode >> styleName [

	^ 'toolBar.label'
]
