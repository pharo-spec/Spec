"
A BIChooseMethodUITest is a test class for testing the behavior of BIChooseMethodUI
"
Class {
	#name : #SpChooseMethodUITest,
	#superclass : #TestCase,
	#instVars : [
		'biChooseMethod'
	],
	#category : #'Spec2-PolyWidgets-Tests'
}

{ #category : #running }
SpChooseMethodUITest >> setUp [
	super setUp.
	biChooseMethod := SpChooseMethodUI new
]

{ #category : #tests }
SpChooseMethodUITest >> testClassSideRadioButtonState [
	biChooseMethod radioButtonClassSide click.
	self deny: biChooseMethod isInstanceButtonSelected
]

{ #category : #tests }
SpChooseMethodUITest >> testClickOnClassSideRadioButtonShouldFillTheMethodList [
	biChooseMethod packageList selectItem: SpMethodChooserMockClass package.
	biChooseMethod classList selectItem: SpMethodChooserMockClass.
	biChooseMethod radioButtonClassSide click.
	self assertCollection: biChooseMethod methodList items hasSameElements: SpMethodChooserMockClass class methods
]

{ #category : #tests }
SpChooseMethodUITest >> testInitializeClassListShouldBeSelectTheFistItem [
	self assert: biChooseMethod classList selection selectedIndex equals: 1
]

{ #category : #tests }
SpChooseMethodUITest >> testInitializeIsInstanceButtonSelectedShouldBetrue [
	self assert: biChooseMethod isInstanceButtonSelected
]

{ #category : #tests }
SpChooseMethodUITest >> testInitializeMethodListShouldBeSelectTheFistItem [
	self assert: biChooseMethod methodList selection selectedIndex equals: 1
]

{ #category : #tests }
SpChooseMethodUITest >> testInitializePackageListShouldBeSelectTheFistItem [
	self assert: biChooseMethod packageList selection selectedIndex equals: 1
]

{ #category : #tests }
SpChooseMethodUITest >> testInitializeProtocolListShouldSelectedItemSetToAll [
	self
		assert: biChooseMethod protocolList selection selectedItem name
		equals: '-- all --'
]

{ #category : #tests }
SpChooseMethodUITest >> testInstanceSideRadioButtonClickIsInstanceButtonShouldbeTrue [
	biChooseMethod radioButtonClassSide click.
	self deny: biChooseMethod isInstanceButtonSelected.
	biChooseMethod radioButtonInstanceSide click.
	self assert: biChooseMethod isInstanceButtonSelected
]

{ #category : #tests }
SpChooseMethodUITest >> testMethodListContentWhenClassSideIsSelected [
	biChooseMethod radioButtonClassSide click.
	biChooseMethod packageList selectItem: SpMethodChooserMockClass package.
	biChooseMethod classList selectItem: SpMethodChooserMockClass.

	self denyEmpty: biChooseMethod methodList items.
	self assert: biChooseMethod methodList selection selectedIndex equals: 1.
	self assertCollection: SpMethodChooserMockClass class methods hasSameElements: biChooseMethod methodList items
]

{ #category : #tests }
SpChooseMethodUITest >> testMethodListContentWhenInstanceSideIsSelected [
	biChooseMethod radioButtonInstanceSide click.
	biChooseMethod packageList selectItem: SpMethodChooserMockClass package.
	biChooseMethod classList selectItem: SpMethodChooserMockClass.

	self denyEmpty: biChooseMethod methodList items.
	self assert: biChooseMethod methodList selection selectedIndex equals: 1.
	self assertCollection: SpMethodChooserMockClass methods hasSameElements: biChooseMethod methodList items
]

{ #category : #tests }
SpChooseMethodUITest >> testSelectAClassShouldDisplayHisProtcolInProtocolList [
	biChooseMethod packageList
		selectIndex:
			((biChooseMethod packageList items collect: #name)
				indexOf: 'Spec2-PolyWidgets-Tests').
	biChooseMethod classList
		selectIndex:
			((biChooseMethod classList items collect: #name)
				indexOf: 'SpMethodChooserMockClass').
	self
		assertCollection: (biChooseMethod protocolList items collect: #name)
		hasSameElements: #(#'-- all --' #accessing)
]

{ #category : #tests }
SpChooseMethodUITest >> testTransmissionFromPackageToClassList [
	| package |
	package := RPackage named: 'MigratePrettyPrinterUI-Tests-environementEmpty' asSymbol.
	biChooseMethod packageList items: {package}.
	biChooseMethod packageList selectItem: package.
	self assertEmpty: biChooseMethod classList items.
	self assert: biChooseMethod classList selection selectedItem isNil
]

{ #category : #tests }
SpChooseMethodUITest >> testWhenClassSideRadioClickShouldChangeProtocolList [
	biChooseMethod packageList
		selectItem: 'Spec2-PolyWidgets-Tests' asPackage.
	biChooseMethod classList selectItem: SpMethodChooserMockClass.
	biChooseMethod radioButtonClassSide click.
	self
		assertCollection: (biChooseMethod protocolList items collect: #name)
		hasSameElements: SpMethodChooserMockClass class protocols
]

{ #category : #tests }
SpChooseMethodUITest >> testWhenSelectAProtocolShouldMethodListOnlyContainsMethodWithSelectedProtocol [
	biChooseMethod packageList
		selectIndex:
			((biChooseMethod packageList items collect: #name)
				indexOf: 'Migration-Tool-ExternalBrowser').
	biChooseMethod classList
		selectIndex:
			((biChooseMethod classList items collect: #name)
				indexOf: self class name).
	biChooseMethod protocolList
		selectIndex:
			((biChooseMethod protocolList items collect: #name) indexOf: 'running').
	self
		assert:
			(biChooseMethod methodList items
				allSatisfy: [ :method | method category = 'running' ])
]
