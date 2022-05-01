# qb-ricin
 don't eat it

 Harvest a ricin plant for a ricin seed, process ricin seed, combine processed ricin with food and drinks.
 
 Step #1 harvest ricin plant: https://gyazo.com/563874a0692217386e9ad74a45863d20
 Step #2 process ricin seed: https://gyazo.com/72892e24d491c2ef12d234bd713825e2
 Step #3 combine ricin powder with food/drink: https://gyazo.com/c9a34b97eb906d98d496b9581388a36b
 Step #4 poison someone: https://gyazo.com/872714da2cdc0f0c2e6ba3afdcfba9cd
 
 Add these items to your item list shared/items.lua:

['poisoned_tosti'] 				 = {['name'] = 'poisoned_tosti', 			 	  	  	['label'] = 'Grilled Cheese Sandwich', ['weight'] = 200, 		['type'] = 'item', 		['image'] = 'tosti.png', 				['unique'] = false, 	['useable'] = true, ['shouldClose'] = true,   ['combinable'] = nil,   ['description'] = 'Nice to eat'},

['poisoned_twerks_candy'] 		 = {['name'] = 'poisoned_twerks_candy', 			  	  	['label'] = 'Twerks', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'twerks_candy.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Some delicious candy, smells a   bit strange :O'},

['poisoned_snikkel_candy'] 		 = {['name'] = 'poisoned_snikkel_candy', 			  	['label'] = 'Snikkel', 					['weight'] = 100, 		['type'] = 'item', 		['image'] = 'snikkel_candy.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Some delicious candy, smells a bit strange :O'},

['poisoned_sandwich'] 			 = {['name'] = 'poisoned_sandwich', 			  	  		['label'] = 'Sandwich', 				['weight'] = 200, 		['type'] = 'item', 		['image'] = 'sandwich.png', ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Nice bread for your stomach, smells a bit strange'},

['ricin_seed'] 				 	 = {['name'] = 'ricin_seed', 			    ['label'] = 'Ricin Seed', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'weed_seed.png', 		   ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'A seed from a ricin plant'},

['ricin_ready'] 				 = {['name'] = 'ricin_ready', 			    ['label'] = 'Ricin Powder', 				['weight'] = 0, 		['type'] = 'item', 		['image'] = 'cocaine_baggy.png', 		   ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	   ['combinable'] = nil,   ['description'] = 'Processed powder from a ricin seed'},
