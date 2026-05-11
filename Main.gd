extends Node


const container_script_path = "res://mods/MegaLoot/LootContainer.gd"
var container_script: Script
const simulation_script_path = "res://mods/MegaLoot/LootSimulation.gd"
var simulation_script: Script


func _ready():
    _setup_mod()
    get_tree().scene_changed.connect(_on_scene_change)
    log_message("Startup completed")


func _setup_mod():
    container_script = load(container_script_path)
    container_script.take_over_path("res://Scripts/LootContainer.gd")
    simulation_script = load(simulation_script_path)
    simulation_script.take_over_path("res://Scripts/LootSimulation.gd")


func _on_scene_change() -> void:
    var map = get_tree().root.get_node_or_null("Map")
    if not map or map.mapType == "Shelter" or map.mapName == "Tutorial":
        return
    else:
        log_message("Updating map loot")
        _update_military_loot_containers("Crate_Special", map)
        _update_military_loot_containers("Crate_Military", map)
        _update_military_loot_simulation("LS_Vostok", map)


func _update_military_loot_containers(container_name: String, map: Node) -> void:
    var containers = map.find_children(container_name + "*")
    for container in containers:
        var _name = container.containerName
        var _audio = container.audioEvent
        var _locked = container.locked
        
        container.set_script(container_script)
        container.containerName = _name
        container.audioEvent = _audio
        container.military = true
        container.joker = true
        container.stash = false
        container.locked = _locked
        container.visible = true
        container.process_mode = ProcessMode.PROCESS_MODE_ALWAYS
        container._ready()


func _update_military_loot_simulation(simulation_name: String, map: Node) -> void:
    var simulations = map.find_children(simulation_name + "*")
    for simulation in simulations:
        simulation.set_script(simulation_script)
        simulation.military = true
        simulation.ClearBuckets()
        simulation.FillBuckets()
        simulation.GenerateLoot()
        simulation.SpawnItems()


func log_message(message: String) -> void:
    print("[MegaLoot] " + message)
