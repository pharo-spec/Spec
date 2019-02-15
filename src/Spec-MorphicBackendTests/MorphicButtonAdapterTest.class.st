Class {
	#name : #MorphicButtonAdapterTest,
	#superclass : #MorphicAdapterTestCase,
	#category : #'Spec-MorphicBackendTests'
}

{ #category : #running }
MorphicButtonAdapterTest >> classToTest [

	^ ButtonPresenter
]

{ #category : #utils }
MorphicButtonAdapterTest >> emulateCenterClick [

	self emulateClick: MouseButtonEvent blueButton
]

{ #category : #utils }
MorphicButtonAdapterTest >> emulateClick: mouseButtonCode [

	| btn evt |
	btn := presenter adapter widget.
	evt := MouseButtonEvent new setType: nil position: btn center which: mouseButtonCode buttons: mouseButtonCode hand: nil stamp: nil.

	(btn handlesMouseDown: evt) ifTrue: [
		btn mouseDown: evt.
		btn mouseUp: evt].

]

{ #category : #utils }
MorphicButtonAdapterTest >> emulateLeftClick [

	self emulateClick: MouseButtonEvent redButton
]

{ #category : #utils }
MorphicButtonAdapterTest >> emulateRightClick [

	self emulateClick: MouseButtonEvent yellowButton
]

{ #category : #running }
MorphicButtonAdapterTest >> setUp [

	super setUp.
	self openInstance
]

{ #category : #running }
MorphicButtonAdapterTest >> testChangingHelpAffectTheWidget [
	
	presenter help: 'ALabel'.

	self openInstance.

	self assert: presenter adapter widget helpText equals: 'ALabel'
]

{ #category : #running }
MorphicButtonAdapterTest >> testChangingHelpAffectTheWidgetAfterOpen [
	

	self openInstance.

	presenter help: 'ALabel'.

	self assert: presenter adapter widget helpText equals: 'ALabel'
]

{ #category : #running }
MorphicButtonAdapterTest >> testChangingIconAffectTheWidget [
	
	presenter iconName: #pharo.
	
	self openInstance.

	self assert: presenter adapter widget label icon form equals: (self iconNamed: #pharo)
]

{ #category : #running }
MorphicButtonAdapterTest >> testChangingIconAffectTheWidgetAfterOpen [
	
	
	self openInstance.

	presenter iconName: #pharo.

	self assert: presenter adapter widget label icon form equals: (self iconNamed: #pharo)
]

{ #category : #running }
MorphicButtonAdapterTest >> testChangingLabelAffectTheWidget [
	
	presenter label: 'ALabel'.

	self openInstance.

	self assert: presenter adapter widget label equals: 'ALabel'
]

{ #category : #running }
MorphicButtonAdapterTest >> testChangingLabelAffectTheWidgetAfterOpen [
	
	self openInstance.

	presenter label: 'ALabel'.

	self assert: presenter adapter widget label equals: 'ALabel'
]

{ #category : #running }
MorphicButtonAdapterTest >> testClickExecuteAction [
	| actionExecuted |
	
	actionExecuted := false.
	
	presenter action: [ actionExecuted := true].

	self openInstance.

	self deny: actionExecuted.	
		
	self emulateLeftClick.
	
	self assert: actionExecuted.	

]

{ #category : #running }
MorphicButtonAdapterTest >> testFontAffectsTheWidget [

	presenter label: 'ALabel'.
	presenter font: StandardFonts codeFont.

	self openInstance.

	self assert: presenter adapter widget label equals: 'ALabel'.
	self assert: presenter adapter widget font equals: StandardFonts codeFont.

]

{ #category : #running }
MorphicButtonAdapterTest >> testRightClickShouldNotExecuteAction [
	| actionExecuted |
	
	actionExecuted := false.
	
	presenter action: [ actionExecuted := true.].

	self openInstance.

	self deny: actionExecuted.
	
	self emulateRightClick.
	
	self deny: actionExecuted.	

]
