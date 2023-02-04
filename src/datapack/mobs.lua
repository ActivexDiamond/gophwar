data{"gopher_base",
	w = 32*3, h = 32*3,

	speed = 250,
	damage = 1,
	health = 10,
	
	distOffset = -3,
	tolerance = 2,

	biteCooldown = 0.6,--2,
	biteCooldownOffset = 0.5, 
	biteChances = {1, 0.5, 0.25},
	
	drops = {
		compost = 0.5,
		essence = 0.2, 
	},
	wiggleRange = math.pi * 0.03,
	wiggleDuration = 0.2,
}

data{"dryad_tree",
	w = 128*3, h = 128*3,
}

data{"crossbow_base",
	w = 64, h = 64,
	spriteDirectionOffset = math.pi * 0.25,
	cooldown = 0.1,
}

data{"crossbow_base_arrow",
	w = 16, h = 16,
	damage = 5,
	speed = 600,
	spriteDirectionOffset = math.pi * 0.25
}