Class {
	#name : #DiffBuilder,
	#superclass : #Object,
	#instVars : [
		'compareBlock'
	],
	#category : #'Spec2-Code-Diff'
}

{ #category : #building }
DiffBuilder class >> buildPatchFrom: source to: destination [

	^ self new 
		buildPatchFrom: source 
		to: destination
]

{ #category : #private }
DiffBuilder >> applyDiff2: diff origin: source dest: dest [
	| deleteByPosition insertByPosition |
	
	deleteByPosition := (diff 
		select: [ :each | each isDelete ])
		collect: [ :each | each oldPosition -> each ] 
		as: Dictionary.
	
	insertByPosition := (diff
		select: [ :each | each isInsert ])
		collect: [ :each | each newPosition -> each ] 
		as: Dictionary.	
	
	^ source species streamContents: [ :stream |
		source withIndexDo: [ :eachLine :index | 
			deleteByPosition 
				at: index 
				ifPresent: [ :old |
					old element: (source at: index).
					stream nextPut: old.
					insertByPosition 
						at: index 
						ifPresent: [ :new |
							new element: (dest at: index). 
							stream nextPut: new ] ]
				ifAbsent: [ 	
					stream nextPut: ((DiffMatch newOldPosition: index) 
						element: eachLine;
						yourself) ] ] ]
]

{ #category : #private }
DiffBuilder >> applyDiff: diff origin: source dest: dest [
	| sequence i |
	
	sequence := OrderedCollection new.
	i := 1.
	
	diff do: [ :each | 
		[ each oldPosition > i ] 
		whileTrue: [ 
			i < source size 
				ifTrue: [ sequence add: (DiffMatch newOldPosition: i element: (source at: i)) ].
			i := i + 1 ].
		each oldPosition = i
			ifTrue: [
				each isDelete ifTrue: [ 
					sequence add: (each 
						element: (source at: each oldPosition);
						yourself).
					i := i + 1 ].
				each isInsert ifTrue: [ 
					sequence add: (each 
						element: (dest at: each newPosition);
						yourself) ].
				self flag: #TODO. "Here goes 'change' operation (not done yet)" ]
			ifFalse: [ 
				self error: 'Should not happen.' ] ].
		
	[ i < source size 	]
	whileTrue: [ 
		sequence add: (DiffMatch newOldPosition: i element: (source at: i)).
		i := i + 1 ].
	
	^ sequence
	
]

{ #category : #'creating patches' }
DiffBuilder >> buildPatchFrom: source to: dest [
	| diff |

	diff := self diffFrom: source to: dest.
	^ DiffPatch newElements: (self 
		applyDiff: diff 
		origin: source 
		dest: dest)
]

{ #category : #accessing }
DiffBuilder >> comparator: aBlock [

	compareBlock := aBlock
]

{ #category : #private }
DiffBuilder >> compare: a with: b [

	^ compareBlock value: a value: b
]

{ #category : #'creating patches' }
DiffBuilder >> diffFrom: origin to: dest [

	^ self 
		diffSource: origin 
		dest: dest 
		posSource: 0
		posDest: 0
]

{ #category : #private }
DiffBuilder >> diffSource: source dest: dest posSource: posSource posDest: posDest [
	| sourceLength destLength totalLength matrixLength |

	"
	Z := no idea :)
	"
	sourceLength := source size.
	destLength := dest size.
	totalLength := sourceLength + destLength.
	matrixLength := ((sourceLength min: destLength)*2)+2.

	(sourceLength>0 and: [ destLength>0 ]) 
		ifTrue: [ 
			| w g p |
			w := sourceLength-destLength. 
			g := Array new: matrixLength withAll: 0.
			p := Array new: matrixLength withAll: 0. 
			
			0 to: ((totalLength//2)+((totalLength%2) = 0 ifTrue: [0] ifFalse: [1])) do: [ :h |
				0 to: 1 do: [ :r |
					| c d o m |
					r = 0 
						ifTrue: [ c := g. d := p. o := 1. m := 1 ]
						ifFalse: [ c := p. d := g. o := 0. m := -1 ].
					(h-(2*((h-destLength) max: 0))) negated 
						to: (h-(2*((h-sourceLength) max: 0)))+1 
						by: 2
						do: [ :k | 
							| a b s t z |
							a := (k=(h negated)
								or: [ (k~=h) and: [ (c at: ((k-1)%matrixLength)+1) < (c at: ((k+1)%matrixLength)+1) ] ])
								ifTrue: [ c zAt: ((k+1)%matrixLength) ]
								ifFalse: [ (c zAt: ((k-1)%matrixLength))+1 ]. 
							b := a-k.
							s := a.
							t := b.
							[ a<sourceLength 
								and: [ b<destLength 
								and: [ 
									self 
										compare: (source zAt: (((1-o)*sourceLength)+(m*a)+(o-1))) 
										with: (dest zAt: (((1-o)*destLength)+(m*b)+(o-1))) ] ] ]
								whileTrue: [ 
									a := a + 1.
									b := b + 1 ].
							c zAt: (k%matrixLength) put: a. 
							z := (k-w) negated.
							((totalLength%2)=o 
								and: [ z >= (h-o) negated 
								and: [ z <= (h-o) 
								and: [ (c zAt: k%matrixLength) + (d zAt: z%matrixLength) >= sourceLength ] ] ]) 
								ifTrue: [  
									| D x y u v |
									o = 1 
										ifTrue: [ D := (2*h)-1. x := s. y := t. u := a. v := b ]
										ifFalse: [ D := 2*h. x := sourceLength-a. y := destLength-b. u := sourceLength-s. v := destLength-t ].
									^ (D > 1 or: [ (x ~= u) and: [ y ~= v ] ])
										ifTrue: [
											(self 
												diffSource: (source zCopyFrom: 0 to: x)  
												dest: (dest zCopyFrom: 0 to: y) 
												posSource: posSource 
												posDest: posDest),
											(self 
												diffSource: (source zCopyFrom: u to: sourceLength)  
												dest: (dest zCopyFrom: v to: destLength) 
												posSource: posSource+u
												posDest: posDest+v) ]
										ifFalse: [ 
											destLength > sourceLength 
												ifTrue: [
													self 
														diffSource: #()
														dest: (dest zCopyFrom: sourceLength to: destLength)
														posSource: posSource+sourceLength 
														posDest: posDest+sourceLength ]
												ifFalse: [ 
													destLength < sourceLength 
														ifTrue: [
															self 
																diffSource: (source zCopyFrom: destLength to: sourceLength) 
																dest: #()
																posSource: posSource+destLength 
																posDest: posDest+destLength ]
														ifFalse: [ 
															#() ] 
													] 
											]
								]
						]
					] 
				] 
			]
		ifFalse: [  
			sourceLength > 0 
				ifTrue: [ 
					^ (1 to: sourceLength) collect: [ :index | DiffDelete newOldPosition: (posSource+index) ] ]
				ifFalse: [ 
					^ (1 to: destLength) collect: [ :index | DiffInsert newOldPosition: posSource+1 newPosition: (posDest+index) ] ] ]
]

{ #category : #initialization }
DiffBuilder >> initialize [

	super initialize.
	self comparator: [ :a :b | a = b ]
]
