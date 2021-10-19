Class {
	#name : #SpVerticalBoxLayoutTest,
	#superclass : #SpBoxLayoutTest,
	#category : #'Spec2-Tests-Layout'
}

{ #category : #initialization }
SpVerticalBoxLayoutTest >> initializeTestedInstance [

	layout := SpBoxLayout newTopToBottom.
	presenter layout: layout
]

{ #category : #tests }
SpVerticalBoxLayoutTest >> testPresenterExtentFollowsChildrenExtent [
	| label button |

	layout 
		add: ((label := presenter newLabel) label: 'Label1');
		add: ((button := presenter newButton) label: 'Button1').
		
	self openInstance.
	
	self assert: (self widthOf: presenter) >= ((self widthOf: label) max: (self widthOf: button)).
	self assert: (self heightOf: presenter) >= ((self heightOf: label) + (self heightOf: button))
]

{ #category : #tests }
SpVerticalBoxLayoutTest >> testReplaceWithFixedHeight [
	| p1 toReplace p3 replacement |

	layout add: (p1 := SpLabelPresenter new).
	layout add: (toReplace := SpLabelPresenter new) height: 100.
	layout add: (p3 := SpLabelPresenter new).
	
	self assert: layout children second equals: toReplace.
	
	replacement := SpButtonPresenter new.
	layout replace: toReplace with: replacement.
	
	self assert: layout children second equals: replacement.
	self assert: layout children size equals: 3.
	self assert: layout children equals: { p1. replacement. p3 }
]

{ #category : #tests }
SpVerticalBoxLayoutTest >> testReplaceWithFixedHeightAllFixed [
	| p1 toReplace p3 replacement |

	layout add: (p1 := SpLabelPresenter new) height: 100.
	layout add: (toReplace := SpLabelPresenter new) height: 100.
	layout add: (p3 := SpLabelPresenter new) height: 100.
	
	self assert: layout children second equals: toReplace.
	
	replacement := SpButtonPresenter new.
	layout replace: toReplace with: replacement.
	
	self assert: layout children second equals: replacement.
	self assert: layout children size equals: 3.
	self assert: layout children equals: { p1. replacement. p3 }
]

{ #category : #tests }
SpVerticalBoxLayoutTest >> testReplaceWithFixedHeightComposed [
	| p1 layoutToReplace toReplace p3 replacement |

	layout add: (p1 := SpLabelPresenter new) width: 100.
	layout add: ((layoutToReplace := SpBoxLayout newTopToBottom)  
		add: (toReplace := SpLabelPresenter new) height: 100;
		add: (SpLabelPresenter new) height: 100;
		yourself).
	layout add: (p3 := SpLabelPresenter new) width: 100.
	
	replacement := SpButtonPresenter new.
	layoutToReplace 
		replace: toReplace 
		with: replacement.
	
	self assert: layout children second children first equals: replacement
]
