"
Display the toolbar with icons only
"
Class {
	#name : #ToolBarDisplayModeIcon,
	#superclass : #ToolBarDisplayMode,
	#category : #'Spec-PolyWidgets-Toolbar'
}

{ #category : #configuring }
ToolBarDisplayModeIcon >> configureButton: aButton item: aToolbarItem [
	"ask for icon (no label)"
	aButton getIconSelector: #icon.
	aButton badgeSelector: #badge.
]

{ #category : #accessing }
ToolBarDisplayModeIcon >> extent [
	^ 25@25
]
