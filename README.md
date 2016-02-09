# cccitygen
ComputerCraft Procedural City Generation Framework - taking city generation with command computers to the next level.

This project aims at providing a solid, object-oriented base for procedural city generation in Minecraft. Rather than being a single script (as most of other city generators out there), CCCG mirrors the hierarchy of real world cities in OOP, from districts down to furniture in individual rooms, and uses this pattern to rebuild these structures in Minecraft worlds, procedurally. Apart from being a framework, it also includes example city generation scripts and working assets that can be used freely in any other project (open source FTW! All contents of this repository are licensed under the MIT license).

## WIP Notice
> CCCG is still quite young, most of the planned features are missing! I am working hard on bringing it into a usable state, but that will take quite some time. Once the repo hits the first pre-release (0.1) I will switch to a [nicer development flow](http://nvie.com/posts/a-successful-git-branching-model/), but for now all commits are dumped straight to `master`.

~ [@viluon](https://github.com/viluon)

## Features
A list of working features implemented to date.
* **Blocks**
	* Support full NBT data
	* Separate ID and block value fields
	* `solid` field for distinction between solid and non-solid blocks
* **Walls**
	* Extend Grid3D
* **Rooms**
	* Implement IHasChildren
		* Support for any children that have the `:build()` method implemented
	* So far only support for exactly 4 Walls, Walls can be theoretically empty though
	* Ceiling and floor, handled differently than Walls but are in fact instances of Wall

## Credits
Thanks to [@Exerro](https://github.com/Exerro) for his *amazing* class library.
