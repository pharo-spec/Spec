Class {
	#name : #TextAdapterTest,
	#superclass : #AbstractWidgetAdapterTestCase,
	#category : #'Spec-BackendTests'
}

{ #category : #accessing }
TextAdapterTest >> classToTest [

	^ TextPresenter
]

{ #category : #accessing }
TextAdapterTest >> testRightClickShowsMenu [
	| menu |

	presenter contextMenu: (menu := SpecMockMenuPresenter new).
	self deny: menu shown.
	self emulateRightClick.
	self assert: menu shown
]
