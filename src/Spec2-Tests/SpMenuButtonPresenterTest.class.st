Class {
	#name : 'SpMenuButtonPresenterTest',
	#superclass : 'SpAbstractButtonPresenterTest',
	#category : 'Spec2-Tests-Core-Widgets',
	#package : 'Spec2-Tests',
	#tag : 'Core-Widgets'
}

{ #category : 'accessing' }
SpMenuButtonPresenterTest >> classToTest [

	^ SpMenuButtonPresenter
]

{ #category : 'tests' }
SpMenuButtonPresenterTest >> testSmokeMenu [
	
	presenter menu: (SpMenuPresenter new
		addGroup: [ :group | group
			addItem: [ :item | item name: 'One' ];
			addItem: [ :item | item name: 'Two' ];
			addItem: [ :item | item name: 'Three' ] ];
		yourself).
	self openInstance
]
