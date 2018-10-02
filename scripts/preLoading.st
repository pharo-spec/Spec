"Remove baseline to ensure it will load it"
(#BaselineOfSpec asPackageIfAbsent: [ nil ])
	ifNotNil: [ :package | package removeFromSystem ].