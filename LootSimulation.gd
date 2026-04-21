extends "res://Scripts/LootSimulation.gd"


func FillBuckets():
    if LT_Master.items.size() != 0:
        for item in LT_Master.items:
            if item.name == "Empty Can":
                continue

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
        if legendaryBucket.size() != 0:
            for pick in 1:
                loot.append(legendaryBucket.pick_random())

    elif rarityRoll <= 25:
        if rareBucket.size() != 0:
            for pick in randi_range(2, 4):
                loot.append(rareBucket.pick_random())

    elif rarityRoll <= 75:
        if commonBucket.size() != 0:
            for pick in randi_range(5, 10):
                loot.append(commonBucket.pick_random())

    elif rarityRoll >= 99:
        if legendaryBucket.size() != 0:
            for pick in 2:
                loot.append(legendaryBucket.pick_random())
                
        if rareBucket.size() != 0:
            for pick in randi_range(2, 4):
                loot.append(rareBucket.pick_random())

        if commonBucket.size() != 0:
            for pick in randi_range(2, 4):
                loot.append(commonBucket.pick_random())
