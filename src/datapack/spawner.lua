data{"gopher_spawner",
	maxAngle = 360,
	minDistance = 500,
	maxDistance = 1000,
	stageMarkers = {0, 8, 20, 35, 60},
	--stageMarkers = {0, 2, 4, 6},
	stageStats = {
		{--1
			cooldown = 3,
			chance = 0,
		},{--2
			cooldown = 2,
			chance = 0.8,
		},{--3
			cooldown = 2,
			chance = 0.5,
		},{--4
			cooldown = 0.9,
			chance = 0.4,
		},{--5
			cooldown = 0.7,
			chance = 0.4,
		},		
	},
}

data{"decoration_spawner",
	treeCountMin = 20,
	treeCountMax = 30,
}
