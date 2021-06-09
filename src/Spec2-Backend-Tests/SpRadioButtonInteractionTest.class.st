Class {
	#name : #SpRadioButtonInteractionTest,
	#superclass : #SpAbstractAdapterTest,
	#category : #'Spec2-Backend-Tests-Base'
}

{ #category : #accessing }
SpRadioButtonInteractionTest >> classToTest [

	^ SpTestPresenterWithThreeRadioButtons 
]

{ #category : #tests }
SpRadioButtonInteractionTest >> testClickingRadio3DeselectsRadio1 [

	self openInstance.
	self presenter radio3 adapter clicked.
	
	self deny: self presenter radio1 state
]

{ #category : #tests }
SpRadioButtonInteractionTest >> testClickingRadio3DeselectsRadio2 [

	self openInstance.
	self presenter radio3 adapter clicked.
	
	self deny: self presenter radio2 state
]

{ #category : #tests }
SpRadioButtonInteractionTest >> testClickingRadio3SelectsIt [

	self openInstance.
	self presenter radio3 adapter clicked.
	
	self assert: self presenter radio3 state
]

{ #category : #tests }
SpRadioButtonInteractionTest >> testHidePresenterHidesWidget [

	"Composable presenters do not have adapters so this test breaks..."
	self skip
]

{ #category : #tests }
SpRadioButtonInteractionTest >> testRadio1StartsDeselected [

	self deny: self presenter radio1 state
]

{ #category : #tests }
SpRadioButtonInteractionTest >> testRadio2StartsSelected [

	self assert: self presenter radio2 state
]

{ #category : #tests }
SpRadioButtonInteractionTest >> testRadio2WidgetStartsSelected [

	self openInstance.

	self assert: self presenter radio2 adapter state
]

{ #category : #tests }
SpRadioButtonInteractionTest >> testRadio3StartsDeselected [

	self openInstance.
	self deny: self presenter radio3 state
]

{ #category : #tests }
SpRadioButtonInteractionTest >> testShowPresenterShowsWidget [

	"Composable presenters do not have adapters so this test breaks..."
	self skip
]
