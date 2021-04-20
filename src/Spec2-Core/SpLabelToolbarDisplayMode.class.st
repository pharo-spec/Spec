"
Display the toolbar with labels only
"
Class {
	#name : #SpLabelToolbarDisplayMode,
	#superclass : #SpToolbarDisplayMode,
	#category : #'Spec2-Core-Widgets'
}

{ #category : #configuring }
SpLabelToolbarDisplayMode >> configureButton: aButton item: aToolbarItem [
	"ask for label (no icon)"
	aButton getLabelSelector: #label.
	aButton badgeSelector: #badge.
]

{ #category : #accessing }
SpLabelToolbarDisplayMode >> extent [
	^ 45@25
]

{ #category : #accessing }
SpLabelToolbarDisplayMode >> styleName [

	^ 'toolBar.label'
]
