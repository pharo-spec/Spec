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
SpAbstractTreePresenterTest >> testSelectAll [

	presenter beSingleSelection. 
	presenter selectAll.
	"in single mode selectAll has no effect"
	self assertEmpty: presenter selection selectedPaths.
	presenter beMultipleSelection.
	presenter selectAll.
	"but in multiple mode selectAll works" 
	self
		assert: presenter selection selectedItems asArray
		equals:
			#( 1 10 100 101 102 103 104 105 106 107 108 109 110 11 110 111 112
			   113 114 115 116 117 118 119 120 12 120 121 122 123 124 125 126
			   127 128 129 130 13 130 131 132 133 134 135 136 137 138 139 140
			   14 140 141 142 143 144 145 146 147 148 149 150 15 150 151 152
			   153 154 155 156 157 158 159 160 16 160 161 162 163 164 165 166
			   167 168 169 170 17 170 171 172 173 174 175 176 177 178 179 180
			   18 180 181 182 183 184 185 186 187 188 189 190 19 190 191 192
			   193 194 195 196 197 198 199 200 20 200 201 202 203 204 205 206
			   207 208 209 210 2 20 200 201 202 203 204 205 206 207 208 209 210
			   21 210 211 212 213 214 215 216 217 218 219 220 22 220 221 222
			   223 224 225 226 227 228 229 230 23 230 231 232 233 234 235 236
			   237 238 239 240 24 240 241 242 243 244 245 246 247 248 249 250
			   25 250 251 252 253 254 255 256 257 258 259 260 26 260 261 262
			   263 264 265 266 267 268 269 270 27 270 271 272 273 274 275 276
			   277 278 279 280 28 280 281 282 283 284 285 286 287 288 289 290
			   29 290 291 292 293 294 295 296 297 298 299 300 30 300 301 302
			   303 304 305 306 307 308 309 310 3 30 300 301 302 303 304 305 306
			   307 308 309 310 31 310 311 312 313 314 315 316 317 318 319 320
			   32 320 321 322 323 324 325 326 327 328 329 330 33 330 331 332
			   333 334 335 336 337 338 339 340 34 340 341 342 343 344 345 346
			   347 348 349 350 35 350 351 352 353 354 355 356 357 358 359 360
			   36 360 361 362 363 364 365 366 367 368 369 370 37 370 371 372
			   373 374 375 376 377 378 379 380 38 380 381 382 383 384 385 386
			   387 388 389 390 39 390 391 392 393 394 395 396 397 398 399 400
			   40 400 401 402 403 404 405 406 407 408 409 410 )
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
