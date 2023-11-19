Class {
	#name : 'SpTextInputFieldPresenterStyleTest',
	#superclass : 'TestCase',
	#category : 'Spec2-Adapters-Morphic-Tests',
	#package : 'Spec2-Adapters-Morphic-Tests'
}

{ #category : 'tests' }
SpTextInputFieldPresenterStyleTest >> testApplyHeightChangesTheHeightOfTheWidget [
	| app presenter textInputField |

	app := SpApplication new.
	app addStyleSheetFromString: '.application [
		.textInputField [ Geometry { #height: 34, #minHeight: 34 } ]	
	]'.
	presenter := SpPresenter newApplication: app.
	presenter layout: (SpBoxLayout newVertical
		add: (textInputField := presenter newTextInput) expand: false;
		yourself).
	presenter build.
		
	self
		assert: textInputField adapter widgetHeight 
		equals: 34
]
