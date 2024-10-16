Class {
	#name : 'SpActionMenuPresenterBuilder',
	#superclass : 'SpMenuPresenterBuilder',
	#category : 'Spec2-Commander2-Action',
	#package : 'Spec2-Commander2',
	#tag : 'Action'
}

{ #category : 'private' }
SpActionMenuPresenterBuilder >> fillItem: aMenuItem with: aCommand [

	super fillItem: aMenuItem with: aCommand.
	aMenuItem name: aCommand dynamicName
]

{ #category : 'accessing' }
SpActionMenuPresenterBuilder >> menuPresenter: aMenuPresenter [

	menuPresenter := aMenuPresenter.
	stack := Stack new
		push: self menuPresenter;
		yourself
]

{ #category : 'visiting' }
SpActionMenuPresenterBuilder >> visitCommand: aCmCommand [

	aCmCommand isVisible ifFalse: [ ^ self ].
	super visitCommand: aCmCommand
]

{ #category : 'visiting' }
SpActionMenuPresenterBuilder >> visitCommandDynamicGroup: aDynamicGroup [

	aDynamicGroup 
		displayIn: stack top 
		do: [ :specGroupOrSubMenu | 
			| group |
			stack push: specGroupOrSubMenu.
			group := SpActionGroup new.
			aDynamicGroup dynamicBuilder value: group.
			group entries do: [ :each |
				each acceptVisitor: self ].
			stack pop ]
]
