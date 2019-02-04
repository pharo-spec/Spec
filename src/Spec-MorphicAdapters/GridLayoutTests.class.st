Class {
	#name : #GridLayoutTests,
	#superclass : #TestCase,
	#instVars : [
		'label1',
		'morph1',
		'label2',
		'morph2',
		'panel'
	],
	#category : #'Spec-MorphicAdapters-Layout'
}

{ #category : #running }
GridLayoutTests >> setUp [
	
	super setUp.
	panel := Morph new
		extent: 100@100;
		addMorphBack: ((label1 := Morph new)
			extent: 50@20;
			yourself); 
		addMorphBack: ((morph1 := Morph new) 
			extent: 50@20;
			yourself); 
		addMorphBack: ((label2 := Morph new) 
			extent: 50@20;
			yourself); 
		addMorphBack: ((morph2 := Morph new) 
			extent: 50@20;
			yourself);
		yourself
]

{ #category : #tests }
GridLayoutTests >> testBasicLayout [
	"
	-----------
	| 50 | 50 |
	-----------
	| 50 | 50 |
	-----------
	"
	| layout |
	
	label1 layoutProperties: (GridLayoutProperties at: 1@1).
	morph1 layoutProperties: (GridLayoutProperties at: 2@1).
	label2 layoutProperties: (GridLayoutProperties at: 1@2).
	morph2 layoutProperties: (GridLayoutProperties at: 2@2).
	
	layout := GridLayout new.
	layout layout: panel in: (0@0 corner: 100@100).
	
	self assert: label1 bounds equals: (0@0 corner: 50@20).
	self assert: morph1 bounds equals: (50@0 corner: 100@20).	
	self assert: label2 bounds equals: (0@20 corner: 50@40).
	self assert: morph2 bounds equals: (50@20 corner: 100@40)

]

{ #category : #tests }
GridLayoutTests >> testColumnHomogeneousDiferentRowsAndColumns [
	"Each element in a different row and column
	
	-------------------------
	| 100 |     |     |     |
	-------------------------
	|     | 100 |     |     |
	-------------------------
	|     |     | 100 |     |
	-------------------------
	|     |     |     | 100 |
	-------------------------	
	"
	| layout |
	
	label1 layoutProperties: (GridLayoutProperties at: 1@1).
	morph1 layoutProperties: (GridLayoutProperties at: 2@2).
	label2 layoutProperties: (GridLayoutProperties at: 3@3).
	morph2 layoutProperties: (GridLayoutProperties at: 4@4).
			
	layout := GridLayout new.
	layout columnHomogeneous: true.
	"make one coljumn width to 100 (it should force all columns to 100, instead 50)"
	label2 width: 100. 
	
	layout layout: panel in: (0@0 corner: 100@100).
	
	self assert: label1 bounds equals: (0@0 corner: 100@20).
	self assert: morph1 bounds equals: (100@20 corner: 200@40).	
	self assert: label2 bounds equals: (200@40 corner: 300@60).
	self assert: morph2 bounds equals: (300@60 corner: 400@80)

]

{ #category : #tests }
GridLayoutTests >> testColumnNotHomogeneousDiferentRowsAndColumns [
	"Each element in a different row and column
	
	-------------------------
	| 30  |     |     |     |
	-------------------------
	|     | 40  |     |     |
	-------------------------
	|     |     | 50  |     |
	-------------------------
	|     |     |     | 60  |
	-------------------------	
	"
	| layout |
	
	label1 layoutProperties: (GridLayoutProperties at: 1@1).
	morph1 layoutProperties: (GridLayoutProperties at: 2@2).
	label2 layoutProperties: (GridLayoutProperties at: 3@3).
	morph2 layoutProperties: (GridLayoutProperties at: 4@4).
	
	layout := GridLayout new.
	layout columnHomogeneous: false.
	"make columns differ, to make each column different"
	label1 width: 30.
	morph1 width: 40.
	label2 width: 50.
	morph2 width: 60.
	
	layout layout: panel in: (0@0 corner: 100@100).
	
	self assert: label1 bounds equals: (0@0 corner: 30@20).
	self assert: morph1 bounds equals: (30@20 corner: 70@40).	
	self assert: label2 bounds equals: (70@40 corner: 120@60).
	self assert: morph2 bounds equals: (120@60 corner: 180@80)

]

{ #category : #tests }
GridLayoutTests >> testColumnNotHomogeneousPairedRowsAndColumns [
	"Paired elements in a rows and columns
	
	-----------
	| 50 | 60 |
	-----------
	| 50 | 60 |
	-----------
	
	"
	| layout |
	
	label1 layoutProperties: (GridLayoutProperties at: 1@1).
	morph1 layoutProperties: (GridLayoutProperties at: 2@1).
	label2 layoutProperties: (GridLayoutProperties at: 1@2).
	morph2 layoutProperties: (GridLayoutProperties at: 2@2).
	
	layout := GridLayout new.
	layout columnHomogeneous: false.
	"make columns differ, to make each column different"
	label1 width: 30.
	morph1 width: 40.
	label2 width: 50.
	morph2 width: 60.
	
	layout layout: panel in: (0@0 corner: 100@100).
	
	self assert: label1 bounds equals: (0@0 corner: 50@20).
	self assert: morph1 bounds equals: (50@0 corner: 110@20).	
	self assert: label2 bounds equals: (0@20 corner: 50@40).
	self assert: morph2 bounds equals: (50@20 corner: 110@40)

]

{ #category : #tests }
GridLayoutTests >> testLayoutIn [
	"This is a meta-test that tries all the others."

	(self class localSelectors 
		reject: [ :each | each = #testLayoutIn ])
		select: [ :each | each beginsWith: 'test' ]
		thenDo: [ :each |
			self setUp.
			self perform: each.
			self tearDown ]
]

{ #category : #tests }
GridLayoutTests >> testSpanColumn [
	"Each element in a different row and column
	
	--------------------
	| 50  |  50  | 50  | 
	--------------------
	|     |        100 | 
	--------------------
	"
	| layout |
	
	label1 layoutProperties: (GridLayoutProperties at: 1@1).
	morph1 layoutProperties: (GridLayoutProperties at: 2@1).
	label2 layoutProperties: (GridLayoutProperties at: 3@1).
	morph2 layoutProperties: (GridLayoutProperties at: 2@2 span: 2@1).
	
	layout := GridLayout new.
	layout layout: panel in: (0@0 corner: 100@100).
	
	self assert: label1 bounds equals: (0@0 corner: 50@20).
	self assert: morph1 bounds equals: (50@0 corner: 100@20).	
	self assert: label2 bounds equals: (100@0 corner: 150@20).
	self assert: morph2 bounds equals: (50@20 corner: 150@40)

]

{ #category : #tests }
GridLayoutTests >> testSpanRow [
	"Each element in a different row and column
	
	--------------------
	| 50  |      |     | 
	-------  50  -------
	| 50  |      | 50  | 
	--------------------
	"
	| layout |
	
	label1 layoutProperties: (GridLayoutProperties at: 1@1).
	morph1 layoutProperties: (GridLayoutProperties at: 2@1 span: 1@2).
	label2 layoutProperties: (GridLayoutProperties at: 1@2).
	morph2 layoutProperties: (GridLayoutProperties at: 3@2).
	
	layout := GridLayout new.
	layout layout: panel in: (0@0 corner: 100@100).
	
	self assert: label1 bounds equals: (0@0 corner: 50@20).
	self assert: morph1 bounds equals: (50@0 corner: 100@40).	
	self assert: label2 bounds equals: (0@20 corner: 50@40).
	self assert: morph2 bounds equals: (100@20 corner: 150@40)

]
