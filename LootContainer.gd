extends LootContainer


var lootable_keys: Array = ["Cellar Key", "Gymnasium Key", "Tunnel Key"]
var loot_keys: Array = []


func FillBuckets():
    if LT_Master.items.size() != 0:
        for item in LT_Master.items:
            if item.name == "Empty Can":
                continue
                
            if item.name in lootable_keys:
                loot_keys.append(item)

            if item.rarity != item.Rarity.Null:

                if (civilian && item.civilian) || (industrial && item.industrial) || (military && item.military):

                    if limit == "" && exclude != item.type:
                        if item.rarity == item.Rarity.Common: commonBucket.append(item)
                        elif item.rarity == item.Rarity.Rare: rareBucket.append(item)
                        elif item.rarity == item.Rarity.Legendary: legendaryBucket.append(item)

                    elif limit == item.type:
                        if item.rarity == item.Rarity.Common: commonBucket.append(item)
                        elif item.rarity == item.Rarity.Rare: rareBucket.append(item)
                        elif item.rarity == item.Rarity.Legendary: legendaryBucket.append(item)


func GenerateLoot():
    rarityRoll = randi_range(1, 100)
    if joker: rarityRoll = 100


    if rarityRoll <= 2:
        CreateLoot(loot_keys.pick_random())
        
        if legendaryBucket.size() != 0:
            for pick in 1:
                CreateLoot(legendaryBucket.pick_random())

    elif rarityRoll <= 25:
        if rareBucket.size() != 0:
            for pick in randi_range(2, 4):
                CreateLoot(rareBucket.pick_random())

    elif rarityRoll <= 75:
        if commonBucket.size() != 0:
            for pick in randi_range(5, 10):
                CreateLoot(commonBucket.pick_random())

    elif rarityRoll >= 99:
        for pick in 2:
            CreateLoot(loot_keys.pick_random())
            
        if legendaryBucket.size() != 0:
            for pick in 2:
                CreateLoot(legendaryBucket.pick_random()) 
                
        if rareBucket.size() != 0:
            for pick in randi_range(2, 4):
                CreateLoot(rareBucket.pick_random())

        if commonBucket.size() != 0:
            for pick in randi_range(2, 4):
                CreateLoot(commonBucket.pick_random())
