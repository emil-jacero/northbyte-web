// NorthByte public catalog — the curated, secret-free source the website renders.
//
// Authored from the public fields of opm-releases/nas2/minecraft/values.cue.
// `featuredMods` are HAND-CURATED highlights (edit freely) — not the full contents
// of a modpack, which bundles many more. Update when servers change.
package northbyte

catalog: #Catalog & {
	brand: {
		name:    "NorthByte"
		tagline: "A small fleet of community game servers in the north. Pick a world, copy the address, jump in."
	}

	servers: {
		"create-survival": {
			type:    "minecraft"
			title:   "Create — Survival"
			connect: "create-survival.mc.northbyte.gg"
			version: "1.21.1"
			loader:  "NeoForge"
			mode:    "Survival"
			blurb:   "Survival with the full Create tech tree — build contraptions, automate everything, and tame the world by hand. Aeronautics enabled."
			modpack: {
				name:    "Create: Ultimate Selection 2"
				url:     "https://modrinth.com/modpack/create-ultimate-selection-2/version/8.6.0"
				version: "8.6.0"
			}
			featuredMods: [
				{name: "Create", kind: "mod", url: "https://modrinth.com/mod/create", blurb: "Mechanical contraptions, automation and aesthetics."},
				{name: "Create: Aeronautics", kind: "mod", url: "https://modrinth.com/mod/create-aeronautics", blurb: "Buildable airships and flying machines."},
				{name: "LuckPerms", kind: "mod", url: "https://modrinth.com/plugin/luckperms", blurb: "Permissions & rank management."},
			]
			tags: ["Modded", "Create", "Tech"]
			order: 10
		}

		"create-creative": {
			type:    "minecraft"
			title:   "Create — Creative"
			connect: "create-creative.mc.northbyte.gg"
			version: "1.21.1"
			loader:  "NeoForge"
			mode:    "Creative"
			blurb:   "The same Create modpack with the brakes off — unlimited blocks and flight for prototyping machines and showpieces."
			modpack: {
				name:    "Create: Ultimate Selection 2"
				url:     "https://modrinth.com/modpack/create-ultimate-selection-2/version/8.6.0"
				version: "8.6.0"
			}
			featuredMods: [
				{name: "Create", kind: "mod", url: "https://modrinth.com/mod/create", blurb: "Mechanical contraptions, automation and aesthetics."},
				{name: "Create: Aeronautics", kind: "mod", url: "https://modrinth.com/mod/create-aeronautics", blurb: "Buildable airships and flying machines."},
				{name: "LuckPerms", kind: "mod", url: "https://modrinth.com/plugin/luckperms", blurb: "Permissions & rank management."},
			]
			tags: ["Modded", "Create", "Creative"]
			order: 20
		}

		"vanilla": {
			type:    "minecraft"
			title:   "Vanilla+"
			connect: "vanilla.mc.northbyte.gg"
			version: "1.21.x"
			loader:  "Paper"
			mode:    "Survival"
			blurb:   "Classic survival on Paper with quality-of-life plugins — EssentialsX, LuckPerms, Multiverse, and a live BlueMap of the world."
			featuredMods: [
				{name: "BlueMap", kind: "plugin", url: "https://modrinth.com/plugin/bluemap", blurb: "Live 3D web map of the world."},
				{name: "EssentialsX", kind: "plugin", url: "https://modrinth.com/plugin/essentialsx", blurb: "Homes, warps, kits and core commands."},
				{name: "LuckPerms", kind: "plugin", url: "https://modrinth.com/plugin/luckperms", blurb: "Permissions & rank management."},
				{name: "Multiverse", kind: "plugin", url: "https://modrinth.com/plugin/multiverse-core", blurb: "Multiple worlds with portals & per-world inventories."},
			]
			tags: ["Survival", "Multiverse", "BlueMap"]
			mapURL: "https://map.vanilla.mc.larnet.eu"
			order:  30
		}

		"cobblemon": {
			type:    "minecraft"
			title:   "Cobblemon"
			connect: "cobblemon.mc.northbyte.gg"
			version: "1.21.1"
			loader:  "Fabric"
			mode:    "Survival"
			blurb:   "Catch, train, and battle Pokémon across a survival world. Fabric-powered, with a live BlueMap to track your journey."
			modpack: {
				name:    "Cobblemon Fabric"
				url:     "https://modrinth.com/modpack/cobblemon-fabric/version/1.7.3"
				version: "1.7.3"
			}
			featuredMods: [
				{name: "Cobblemon", kind: "mod", url: "https://modrinth.com/mod/cobblemon", blurb: "Pokémon catching, training and battling."},
				{name: "BlueMap", kind: "mod", url: "https://modrinth.com/plugin/bluemap", blurb: "Live 3D web map of the world."},
				{name: "LuckPerms", kind: "mod", url: "https://modrinth.com/plugin/luckperms", blurb: "Permissions & rank management."},
			]
			tags: ["Modded", "Pokémon", "Fabric"]
			mapURL: "https://map.cobblemon.larnet.eu"
			hidden: true
			order:  40
		}

		"ron": {
			type:         "minecraft"
			title:        "Reign of Nether"
			connect:      "ron.mc.northbyte.gg"
			version:      "1.20.1"
			loader:       "Fabric"
			mode:         "Creative"
			blurb:        "A real-time-strategy take on Minecraft — command armies and fight for the Nether. An experimental world we spin up to mess around."
			modpack: {
				name:    "Reign of Nether (Optimized)"
				url:     "https://modrinth.com/modpack/reign-of-nether-optimized/version/2.8.0"
				version: "2.8.0"
			}
			featuredMods: [
				{name: "Reign of Nether", kind: "mod", url: "https://modrinth.com/mod/reignofnether", blurb: "RTS gameplay — command units and bases."},
			]
			tags: ["Modded", "RTS", "Experimental"]
			experimental: true
			hidden:       true
			order:        50
		}
	}
}
