data{"gopher_base",
	w = 32*2, h = 32*2,
	flashBaseDuration = 5,
	speed = 150,
	damage = 1,
	health = 10,
	
	distOffset = 155*math.sqrt(2),
	tolerance = 2,

	biteCooldown = 200000000000000000000,--2,
	biteCooldownOffset = 0.5, 
	biteChances = {1, 0.5, 0.25},
	
	drops = {
		compost = 0.5,
		essence = 0.2, 
	},
	wiggleRange = math.pi * 0.03,
	wiggleDuration = 0.2,
	drop = "essence_base",
	dropChance = 0.3,
}

data{"gopher_chonky",
	w = 32*2, h = 32*2,
	flashBaseDuration = 5,
	speed = 100,
	damage = 3,
	health = 22,
	
	distOffset = 155*math.sqrt(2),
	tolerance = 2,

	biteCooldown = 200000000000000000000,--2
	biteCooldownOffset = 0.5, 
	biteChances = {1, 0.5, 0.25},
	
	drops = {
		compost = 0.5,
		essence = 0.2, 
	},
	wiggleRange = math.pi * 0.03,
	wiggleDuration = 0.2,
	
	drop = "essence_chonky",
	dropChance = 0.3,
}

data{"dryad_tree",
	w = 128*5, h = 128*5,
	health = math.huge,--500,
	--flashBaseDuration = 2,
	shakeBaseDuration = 2,
}

data{"tree",
	w = 32*6, h = 32*6,
}

data{"crossbow_base",
	w = 64, h = 64,
	spriteDirectionOffset = math.pi * 0.25,
	cooldown = 0.2,
}

data{"crossbow_base_arrow",
	w = 16, h = 16,
	damage = 5,
	speed = 600,
	spriteDirectionOffset = math.pi * 0.25
}

data{"root",
	w = 16*3, h = 32*3,
	health = 10
}

data{"button",
}

data{"spikes_tier1",
	w = 32*4, h = 32*4,
	health = 5,
	damage = 50,
}

data{"spikes_tier2",
	w = 32*4, h = 32*4,
	health = 10,
	damage = 50,
}