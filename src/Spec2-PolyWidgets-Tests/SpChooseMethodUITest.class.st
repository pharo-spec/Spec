"
A BIChooseMethodUITest is a test class for testing the behavior of BIChooseMethodUI
"
Class {
	#name : #SpChooseMethodUITest,
	#superclass : #TestCase,
	#instVars : [
		'biChooseMethod'
	],
	#category : #'Spec2-PolyWidgets-Tests-tests'
}

{ #category : #util }
SpChooseMethodUITest >> selectClassNamed: aName [
	biChooseMethod classList
		selectIndex:
			(biChooseMethod classList items
				indexOf:
					(biChooseMethod classList items
						detect:
							[ :class | class name = aName ]))
]

{ #category : #util }
SpChooseMethodUITest >> selectPackageNamed: aName [
	biChooseMethod packageList
		selectIndex:
			(biChooseMethod packageList items
				indexOf:
					(biChooseMethod packageList items
						detect:
							[ :package | package name = aName ]))
]

{ #category : #running }
SpChooseMethodUITest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	biChooseMethod := SpChooseMethodUI new.
]

{ #category : #tests }
SpChooseMethodUITest >> testClassSideRadioButtonClickIsInstanceButtonShouldbeFalse [
	biChooseMethod radioButtonClassSide click.
	self deny: biChooseMethod isInstanceButtonSelected
]

{ #category : #tests }
SpChooseMethodUITest >> testClickOnAnOtherItemClassAndisInstanceButtonSelectedSetFalseShouldTransmitToMethodListHisClasssMethodAndSelectTheFirstOne [
	biChooseMethod radioButtonClassSide click.
	self deny: biChooseMethod isInstanceButtonSelected.
	self selectPackageNamed: SpUseForTestWithMethodBySpMethodChooserUI package name.
	self selectClassNamed: SpUseForTestWithMethodBySpMethodChooserUI name.
	self deny: biChooseMethod methodList items isEmpty.
	self
		assert: biChooseMethod methodList selection selectedIndex
		equals: 1.
	self
		assertCollection: SpUseForTestWithMethodBySpMethodChooserUI class methods asOrderedCollection
		hasSameElements: biChooseMethod methodList items
]

{ #category : #tests }
SpChooseMethodUITest >> testClickOnAnOtherItemClassAndisInstanceButtonSelectedSetTrueShouldTransmitToMethodListHisClasssMethodAndSelectTheFirstOne [
	self assert: biChooseMethod isInstanceButtonSelected.
	self selectPackageNamed: SpUseForTestWithMethodBySpMethodChooserUI package name.
	self selectClassNamed: SpUseForTestWithMethodBySpMethodChooserUI name.
	self deny: biChooseMethod methodList items isEmpty.
	self
		assert: biChooseMethod methodList selection selectedIndex
		equals: 1.
	self
		assertCollection: SpUseForTestWithMethodBySpMethodChooserUI methods asOrderedCollection
		hasSameElements: biChooseMethod methodList items
]

{ #category : #tests }
SpChooseMethodUITest >> testClickOnAnOtherItemPackageShouldTransmitToClassListHisPackageClassesAndSelectTheFirstOne [
	| itemListBefore |
	itemListBefore := biChooseMethod classList items.
	self selectPackageNamed: 'Kernel'.
	self deny: biChooseMethod classList items isEmpty.
	self assert: biChooseMethod classList selection selectedIndex equals: 1.
	self deny: (itemListBefore = biChooseMethod classList items)
]

{ #category : #tests }
SpChooseMethodUITest >> testClickOnAnOtherItemPackageWhoClassesAreEmptyShouldTransmitToClassListEmptyCollectionAndSetIndexTo0 [
	biChooseMethod packageList items: { RPackage named: 'MigratePrettyPrinterUI-Tests-environementEmpty' asSymbol  }.
	self selectPackageNamed: 'MigratePrettyPrinterUI-Tests-environementEmpty'.
	self assert: biChooseMethod classList items isEmpty.
	self assert: biChooseMethod classList selection selectedItem isNil
]

{ #category : #tests }
SpChooseMethodUITest >> testClickOnClassSideRAdioButtonShouldFillTheMethodListBySelectedClassListMethodClassSide [
	self selectPackageNamed: SpUseForTestWithMethodBySpMethodChooserUI package name.
	self selectClassNamed: SpUseForTestWithMethodBySpMethodChooserUI name.
	biChooseMethod radioButtonClassSide click.
	self
		assert: biChooseMethod methodList items = SpUseForTestWithMethodBySpMethodChooserUI class methods asOrderedCollection
]

{ #category : #tests }
SpChooseMethodUITest >> testInitializeClassListShouldBeSelectTheFistItem [
	self
		assert: biChooseMethod classList selection selectedIndex
		equals: 1
]

{ #category : #tests }
SpChooseMethodUITest >> testInitializeIsInstanceButtonSelectedShouldBetrue [
	self assert: biChooseMethod isInstanceButtonSelected.
]

{ #category : #tests }
SpChooseMethodUITest >> testInitializeMethodListShouldBeSelectTheFistItem [
	self
		assert: biChooseMethod methodList selection selectedIndex
		equals: 1
]

{ #category : #tests }
SpChooseMethodUITest >> testInitializePackageListShouldBeSelectTheFistItem [
	self
		assert: biChooseMethod packageList selection selectedIndex
		equals: 1
]

{ #category : #tests }
SpChooseMethodUITest >> testInstanceSideRadioButtonClickIsInstanceButtonShouldbeTrue [
	biChooseMethod radioButtonClassSide click.
	self deny: biChooseMethod isInstanceButtonSelected.
	biChooseMethod radioButtonInstanceSide click.
	self assert: biChooseMethod isInstanceButtonSelected
]
