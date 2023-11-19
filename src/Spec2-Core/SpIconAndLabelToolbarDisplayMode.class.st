"
Display the toolbar with icons and label only
"
Class {
	#name : 'SpIconAndLabelToolbarDisplayMode',
	#superclass : 'SpToolbarDisplayMode',
	#category : 'Spec2-Core-Widgets',
	#package : 'Spec2-Core',
	#tag : 'Widgets'
}

{ #category : 'configuring' }
SpIconAndLabelToolbarDisplayMode >> configureButton: aButton item: aToolbarItem [
	"ask for icon and label"
	aButton getLabelSelector: #label.
	aButton getIconSelector: #icon.
	aButton badgeSelector: #badge.
	aButton getStateSelector: #state
	
]

{ #category : 'accessing' }
SpIconAndLabelToolbarDisplayMode >> extent [
	^ (45@45) scaledByDisplayScaleFactor
]

{ #category : 'printing' }
SpIconAndLabelToolbarDisplayMode >> label [

	^ 'Icon and Label'
]

{ #category : 'accessing' }
SpIconAndLabelToolbarDisplayMode >> styleName [ 

	^ 'toolBar.iconsAndLabel'
]
