#(BaselineOfSpecCore BaselineOfSpec2) do: [ :each | 
	Smalltalk globals 
		at: each 
		ifPresent: [ :aClass | aClass removeFromSystem ] ]
