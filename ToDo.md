
* All overloads for Point3D
* What about the constructor chain interface?
* Grid3D should use Point3D for origin
* Rooms are somewhat limited. They can only have 4 walls. What about non-rectangular rooms?
* Grid3D:resize()
* Should room floors be limited only to the inner area (exclude the borders with walls)?
* Move stuff from ToDo to GitHub Issues
* Implement require(), dofile() is dumb
* Building should keep a list of outside walls
* IDuplicable?
* Generalize Palette, add RoomPalette
* Use RoomPalette in :populate() along with BuildingPopulator or something similar
	* BuildingPopulator will contain a list of rules such as what Rooms the building should use and how should they be connected, how many of them etc
	* BuildingPopulators will define Building types, for example a family house vs. mall etc
	* BuildingPopulators should have a clue about how the building is structured (floors, staircases, elevators?)
