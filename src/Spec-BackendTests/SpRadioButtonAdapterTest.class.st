Class {
	#name : #SpRadioButtonAdapterTest,
	#superclass : #AbstractWidgetAdapterTestCase,
	#category : #'Spec-BackendTests'
}

{ #category : #running }
SpRadioButtonAdapterTest >> classToTest [

	^ SpRadioButtonPresenter 
]

{ #category : #running }
SpRadioButtonAdapterTest >> testChangingLabelAffectTheWidget [
	
	presenter label: 'ALabel'.
	self assert: self widget label equals: 'ALabel'
]

{ #category : #tests }
SpRadioButtonAdapterTest >> testIfSingleRadioButtonStartsSelected [

	self assert: self adapter state.
]
