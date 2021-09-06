#( BaselineOfSpec2 BaselineOfSpecCore ) do: [ :each | 
	(RPackageOrganiser default packageNamed: each ifAbsent: [ nil ]) 
		ifNotNil: [ :aPackage | aPackage removeFromSystem ] ]
