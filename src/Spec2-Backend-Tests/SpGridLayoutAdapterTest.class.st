Class {
	#name : 'SpGridLayoutAdapterTest',
	#superclass : 'SpLayoutAdapterTest',
	#category : 'Spec2-Backend-Tests-Layout',
	#package : 'Spec2-Backend-Tests',
	#tag : 'Layout'
}

{ #category : 'accessing' }
SpGridLayoutAdapterTest >> newLayout [

	^ SpGridLayout new
]

{ #category : 'tests' }
SpGridLayoutAdapterTest >> testAddAtSamePositionTwiceReplacesChild [

	| first second |
	layout add: (first := SpButtonPresenter new) atPoint: 1 @ 1.
	layout add: (second := SpButtonPresenter new) atPoint: 1 @ 1.
	self
		assert: self adapter children first
		equals: second adapter widget
]

{ #category : 'tests' }
SpGridLayoutAdapterTest >> testAddAtSamePositionTwiceSetsChildrenSingleTime [

	layout add: SpButtonPresenter new atPoint: 1 @ 1.
	layout add: SpButtonPresenter new atPoint: 1 @ 1.
	self assert: self adapter children size equals: 1
]

{ #category : 'tests' }
SpGridLayoutAdapterTest >> testAddElementAddsToAdapter [

	layout add: SpButtonPresenter new atPoint: 1 @ 1.
	self deny: self adapter isEmpty
]

{ #category : 'tests' }
SpGridLayoutAdapterTest >> testAddElementAfterOpenAddsToAdapter [

	layout add: SpButtonPresenter new atPoint: 1 @ 1.
	self openInstance.

	layout add: SpButtonPresenter new atPoint: 1 @ 2.
	self assert: self adapter children size equals: 2
]

{ #category : 'tests' }
SpGridLayoutAdapterTest >> testBeColumnHomogeneous [

	layout
		beColumnHomogeneous;
		add: 'Test' atPoint: 1 @ 1;
		add: 'Other label test' atPoint: 2 @ 1.

	self openInstance.

	self
		assert: (self adapter extentOfChildAt: 1) x
		equals: (self adapter extentOfChildAt: 2) x
]

{ #category : 'tests' }
SpGridLayoutAdapterTest >> testBeColumnNotHomogeneous [

	layout
		beColumnNotHomogeneous;
		add: 'Test' atPoint: 1 @ 1;
		add: 'Other label test' atPoint: 2 @ 1.

	self openInstance.

	self
		deny: (self adapter extentOfChildAt: 1) x
		equals: (self adapter extentOfChildAt: 2) x
]

{ #category : 'tests' }
SpGridLayoutAdapterTest >> testBeRowHomogeneous [

	layout
		beRowHomogeneous;
		add: 'Test' atPoint: 1 @ 1;
		add: (presenter newButton extent: 40 @ 40; yourself)
		atPoint: 1 @ 2.

	self openInstance.

	self
		assert: (self adapter extentOfChildAt: 1) y
		equals: (self adapter extentOfChildAt: 2) y
]

{ #category : 'tests' }
SpGridLayoutAdapterTest >> testBeRowNotHomogeneous [

	layout
		beRowNotHomogeneous;
		add: 'Test' atPoint: 1 @ 1;
		add: (presenter newButton extent: 40 @ 40; yourself) atPoint: 1 @ 2.

	self openInstance.

	self
		deny: (self adapter extentOfChildAt: 1) y
		equals: (self adapter extentOfChildAt: 2) y
]

{ #category : 'tests' }
SpGridLayoutAdapterTest >> testColumnSpanColumnHomogeneous [

	layout
		beColumnHomogeneous;
		add: 'Test' atPoint: 1 @ 1 span: 2 @ 1;
		add: 'Other label test' atPoint: 1 @ 2;
		add: 'span column' atPoint: 2 @ 2.

	self openInstance.

	self
		assert: (self adapter extentOfChildAt: 1) x
		equals: (self adapter extentOfChildAt: 2) x
			+ (self adapter extentOfChildAt: 3) x
]

{ #category : 'tests' }
SpGridLayoutAdapterTest >> testColumnSpanColumnNotHomogeneous [

	layout
		beColumnNotHomogeneous;
		add: 'Test' atPoint: 1 @ 1 span: 2 @ 1;
		add: 'Other' atPoint: 1 @ 2;
		add: 'span column, larger' atPoint: 2 @ 2.

	self openInstance.

	"the first column width is equal to the sum of two columns"
	self
		assert: (self adapter extentOfChildAt: 1) x
		equals: (self adapter extentOfChildAt: 2) x
			+ (self adapter extentOfChildAt: 3) x.
	"the first column still needs to be smaller than the first"
	self assert: (self adapter extentOfChildAt: 2) x
		< (self adapter extentOfChildAt: 3) x
]

{ #category : 'tests' }
SpGridLayoutAdapterTest >> testRemoveElementAddedAfterOpenRemovesFromAdapter [

	| element |
	layout add: (element := SpButtonPresenter new) atPoint: 1 @ 1.
	self openInstance.

	layout remove: element.
	self assert: self adapter isEmpty
]

{ #category : 'tests' }
SpGridLayoutAdapterTest >> testRemoveElementRemovesFromAdapter [

	| element |
	layout add: (element := SpButtonPresenter new) atPoint: 1 @ 1.
	layout remove: element.
	self assert: self adapter isEmpty
]

{ #category : 'tests' }
SpGridLayoutAdapterTest >> testRowSpanRowHomogeneous [

	layout
		beRowHomogeneous;
		add: 'Test 1' atPoint: 1 @ 1;
		add: (presenter newButton extent: 40 @ 40; yourself)
		atPoint: 2 @ 1
		span: 1 @ 2;
		add: 'Test 2' atPoint: 1 @ 2.

	self openInstance.

	self
		assert: (self adapter extentOfChildAt: 2) y
		equals: (self adapter extentOfChildAt: 1) y
			+ (self adapter extentOfChildAt: 3) y
]

{ #category : 'tests' }
SpGridLayoutAdapterTest >> testRowSpanRowNotHomogeneous [

	layout
		beRowNotHomogeneous;
		add: 'Test 1' atPoint: 1 @ 1;
		add: (presenter newButton extent: 40 @ 40; yourself)
		atPoint: 2 @ 1
		span: 1 @ 2;
		add: 'Test 2' atPoint: 1 @ 2.

	self openInstance.

	self
		assert: (self adapter extentOfChildAt: 2) y
		equals: (self adapter extentOfChildAt: 1) y
			+ (self adapter extentOfChildAt: 3) y
]
