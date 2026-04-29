Class {
	#name : 'BaselineOfGroupEntries',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfGroupEntries',
	#package : 'BaselineOfGroupEntries'
}

{ #category : 'baselines' }
BaselineOfGroupEntries >> baseline: spec [

	spec for: #'common' do: [
		spec 
			package: #'Group-Entries';
			package: #'Group-Entries-Tests' with: [
				spec requires: #('Group-Entries' ) ].
			]
]
