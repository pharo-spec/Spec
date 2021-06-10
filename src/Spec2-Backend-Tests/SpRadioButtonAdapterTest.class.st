Class {
	#name : #SpRadioButtonAdapterTest,
	#superclass : #SpAbstractWidgetAdapterTest,
	#category : #'Spec2-Backend-Tests-Base'
}

{ #category : #accessing }
SpRadioButtonAdapterTest >> classToTest [

	^ SpRadioButtonPresenter 
]

{ #category : #tests }
SpRadioButtonAdapterTest >> testChangingLabelAffectTheWidget [
	
	presenter label: 'ALabel'.
	self assert: self widget label equals: 'ALabel'
]

{ #category : #tests }
SpRadioButtonAdapterTest >> testIfSingleRadioButtonStartsSelected [

	self assert: self adapter state.
]
