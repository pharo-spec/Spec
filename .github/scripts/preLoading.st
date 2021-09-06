#( BaselineOfSpec2 BaselineOfSpecCore ) do: [ :each | 
	(Smalltalk classNamed: each) 
		ifNotNil: [ :aClass | aClass removeFromSystem ] ]
