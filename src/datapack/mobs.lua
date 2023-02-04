data{"gopher_base",
	w = 32*2, h = 32*2,
	flashBaseDuration = 5,
	speed = 150,
	damage = 1,
	health = 10,
	
	distOffset = 155*math.sqrt(2),
	tolerance = 2,

	biteCooldown = 2,
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

	biteCooldown = 2,
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
	w = 128*3, h = 128*3,
	health = 50,
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
	w = 16, h = 32,
	health = 10
}

