Class {
	#name : 'SpAbstractTreePresenterTest',
	#superclass : 'SpSpecTest',
	#category : 'Spec2-Tests-Core-Widgets',
	#package : 'Spec2-Tests',
	#tag : 'Core-Widgets'
}

{ #category : 'testing' }
SpAbstractTreePresenterTest class >> isAbstract [

	^ super isAbstract or: [ self = SpAbstractTreePresenterTest ]
]

{ #category : 'running' }
SpAbstractTreePresenterTest >> setUp [

	super setUp.
	presenter 
		roots: #(1 2 3);
		children: [ :aNumber | 
			aNumber < 100 
				ifTrue: [ ((aNumber * 10) to: (aNumber * 10) + 10) asArray ]
				ifFalse: [ #() ] ].
	
]

{ #category : 'tests' }
SpAbstractTreePresenterTest >> testActivationOnDoubleClickShouldActivateOnDoubleClick [
	| activatedItem |
	presenter
		activateOnDoubleClick;
		whenActivatedDo: [ :selection | activatedItem := selection selectedItem ].

	presenter doubleClickAtPath: #(1 2 1).

	self assert: activatedItem equals: 110
]

{ #category : 'tests' }
SpAbstractTreePresenterTest >> testActivationOnDoubleClickShouldNotActivateOnClick [
	| activatedItem |
	presenter
		activateOnDoubleClick;
		whenActivatedDo: [ :selection | activatedItem := selection selectedItem ].

	presenter clickAtPath: #(1).

	self assert: activatedItem isNil
]

{ #category : 'tests' }
SpAbstractTreePresenterTest >> testActivationOnSingleClickShouldActivateOnClick [
	| activatedItem |
	presenter
		activateOnSingleClick;
		whenActivatedDo: [ :selection | activatedItem := selection selectedItem ].

	presenter clickAtPath: #(1).

	self assert: activatedItem equals: 1
]

{ #category : 'tests' }
SpAbstractTreePresenterTest >> testActivationOnSingleClickShouldNotActivateOnClickOutside [
	| activatedItem |
	presenter
		activateOnSingleClick;
		whenActivatedDo: [ :selection | activatedItem := selection selectedItem ].

	presenter clickAtPath: #(4).

	self assert: activatedItem isNil
]

{ #category : 'tests' }
SpAbstractTreePresenterTest >> testContextMenu [
	| menu changed |
	self assert: presenter contextMenu isNil.
	menu := SpMenuPresenter new.
	changed := false.
	presenter whenMenuChangedDo: [ 
		changed := true. ].
	presenter contextMenu: menu.
	self assert: presenter contextMenu equals: menu.
	self assert: changed
]

{ #category : 'tests' }
SpAbstractTreePresenterTest >> testDisableActivationDuring [ 
	| activated |

	activated := false.
	presenter whenActivatedDo: [ activated := true ].
	
	self deny: activated.
	presenter disableActivationDuring: [ presenter clickAtPath: #(2) ].
	self deny: activated. "still not change"
	self assert: presenter selectedItem equals: 2 "but the selection changed!"
]

{ #category : 'tests' }
SpAbstractTreePresenterTest >> testExpandAtPathExpandsTheNode [

	self openInstance.
	
	self deny: (presenter isExpanded: #(1)). 
	self deny: (presenter isExpanded: #(1 2)). 
	self deny: (presenter isExpanded: #(1 2 1)). 

	presenter expandPath: #(1 2 1).

	self assert: (presenter isExpanded: #(1)). 
	self assert: (presenter isExpanded: #(1 2)). 
	self assert: (presenter isExpanded: #(1 2 1)). 

]

{ #category : 'tests' }
SpAbstractTreePresenterTest >> testPathIndexOf [

	presenter 
		roots: #(1 2 3);
		children: [ :x | { x * 10 } ].
	
	self 
		assert: (presenter pathIndexOf: #(2 20 200))
		equals: #(2 1 1).
		

]

{ #category : 'tests' }
SpAbstractTreePresenterTest >> testPathItemOf [

	presenter 
		roots: #(1 2 3);
		children: [ :x | { x * 10 } ].
	
	self 
		assert: (presenter pathItemOf: #(2 1 1))
		equals: #(2 20 200).
		

]

{ #category : 'tests' }
SpAbstractTreePresenterTest >> testUnselectAll [

	presenter beMultipleSelection.
	presenter 
		selectPath: #(1);
		selectPath: #(2).
	self assert: presenter selection selectedPaths equals: #((1) (2)).
	presenter unselectAll.
	self assertEmpty: presenter selection selectedPaths.
	

]

{ #category : 'tests' }
SpAbstractTreePresenterTest >> testUpdateRootsKeepingSelection [ 

	presenter roots: #($a $b $c).
	presenter selectPath: #(3).
	presenter updateRootsKeepingSelection: #($c $d $e $f).
	self assert: presenter selectedItem equals: $c
]

{ #category : 'tests' }
SpAbstractTreePresenterTest >> testWhenSelectedItemChangedDo [
	| selectedItem |

	presenter whenSelectedItemChangedDo: [ :item | selectedItem := item ].

	presenter clickAtPath: #(1).

	self assert: selectedItem equals: 1
]
