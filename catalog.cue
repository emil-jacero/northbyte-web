// NorthByte public catalog — the curated, secret-free source the website renders.
//
// Authored from the public fields of opm-releases/nas2/minecraft/values.cue.
// `featuredMods` are HAND-CURATED highlights (edit freely) — not the full contents
// of a modpack, which bundles many more. Update when servers change.
//
// Player-facing prose (tagline, server `blurb`, mod `blurb`) is localized en/sv —
// see #I18n in catalog_schema.cue. UI chrome is translated in site/i18n/*.toml.
package northbyte

catalog: #Catalog & {
	brand: {
		name: "NorthByte"
		tagline: {
			en: "A small fleet of community game servers in the north. Pick a world, copy the address, jump in."
			sv: "Välj en värld, kopiera adressen och hoppa in."
		}
	}

	servers: {
		"create-survival": {
			type:    "minecraft"
			title:   "Create — Survival"
			connect: "create-survival.mc.northbyte.gg"
			version: "1.21.1"
			loader:  "NeoForge"
			mode:    "Survival"
			blurb: {
				en: "Survival with the full Create tech tree — build contraptions, automate everything, and tame the world by hand. Aeronautics enabled."
				sv: "Survival med hela Create-teknikträdet — bygg maskinerier, automatisera allt och tämj världen för hand. Aeronautics aktiverat."
			}
			modpack: {
				name:    "Create: Ultimate Selection 2"
				url:     "https://modrinth.com/modpack/create-ultimate-selection-2/version/8.6.0"
				version: "8.6.0"
			}
			featuredMods: [
				{name: "Create", kind: "mod", url: "https://modrinth.com/mod/create", blurb: {en: "Mechanical contraptions, automation and aesthetics.", sv: "Mekaniska maskinerier, automation och estetik."}},
				{name: "Create: Aeronautics", kind: "mod", url: "https://modrinth.com/mod/create-aeronautics", blurb: {en: "Buildable airships and flying machines.", sv: "Byggbara luftskepp och flygmaskiner."}},
				{name: "LuckPerms", kind: "mod", url: "https://modrinth.com/plugin/luckperms", blurb: {en: "Permissions & rank management.", sv: "Behörigheter och ranghantering."}},
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
			blurb: {
				en: "The same Create modpack with the brakes off — unlimited blocks and flight for prototyping machines and showpieces."
				sv: "Samma Create-modpaket utan broms — obegränsat med block och flygläge för att prototypa maskiner och paradnummer."
			}
			modpack: {
				name:    "Create: Ultimate Selection 2"
				url:     "https://modrinth.com/modpack/create-ultimate-selection-2/version/8.6.0"
				version: "8.6.0"
			}
			featuredMods: [
				{name: "Create", kind: "mod", url: "https://modrinth.com/mod/create", blurb: {en: "Mechanical contraptions, automation and aesthetics.", sv: "Mekaniska maskinerier, automation och estetik."}},
				{name: "Create: Aeronautics", kind: "mod", url: "https://modrinth.com/mod/create-aeronautics", blurb: {en: "Buildable airships and flying machines.", sv: "Byggbara luftskepp och flygmaskiner."}},
				{name: "LuckPerms", kind: "mod", url: "https://modrinth.com/plugin/luckperms", blurb: {en: "Permissions & rank management.", sv: "Behörigheter och ranghantering."}},
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
			blurb: {
				en: "Classic survival on Paper with quality-of-life plugins — EssentialsX, LuckPerms, Multiverse, and a live BlueMap of the world."
				sv: "Klassisk survival på Paper med smidighetstillägg — EssentialsX, LuckPerms, Multiverse och en live-BlueMap över världen."
			}
			featuredMods: [
				{name: "BlueMap", kind: "plugin", url: "https://modrinth.com/plugin/bluemap", blurb: {en: "Live 3D web map of the world.", sv: "Live 3D-webbkarta över världen."}},
				{name: "EssentialsX", kind: "plugin", url: "https://modrinth.com/plugin/essentialsx", blurb: {en: "Homes, warps, kits and core commands.", sv: "Hem, warpar, kit och grundkommandon."}},
				{name: "LuckPerms", kind: "plugin", url: "https://modrinth.com/plugin/luckperms", blurb: {en: "Permissions & rank management.", sv: "Behörigheter och ranghantering."}},
				{name: "Multiverse", kind: "plugin", url: "https://modrinth.com/plugin/multiverse-core", blurb: {en: "Multiple worlds with portals & per-world inventories.", sv: "Flera världar med portaler och separata inventarier per värld."}},
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
			blurb: {
				en: "Catch, train, and battle Pokémon across a survival world. Fabric-powered, with a live BlueMap to track your journey."
				sv: "Fånga, träna och slåss med Pokémon i en survival-värld. Drivs av Fabric, med en live-BlueMap för att följa din resa."
			}
			modpack: {
				name:    "Cobblemon Fabric"
				url:     "https://modrinth.com/modpack/cobblemon-fabric/version/1.7.3"
				version: "1.7.3"
			}
			featuredMods: [
				{name: "Cobblemon", kind: "mod", url: "https://modrinth.com/mod/cobblemon", blurb: {en: "Pokémon catching, training and battling.", sv: "Fånga, träna och slåss med Pokémon."}},
				{name: "BlueMap", kind: "mod", url: "https://modrinth.com/plugin/bluemap", blurb: {en: "Live 3D web map of the world.", sv: "Live 3D-webbkarta över världen."}},
				{name: "LuckPerms", kind: "mod", url: "https://modrinth.com/plugin/luckperms", blurb: {en: "Permissions & rank management.", sv: "Behörigheter och ranghantering."}},
			]
			tags: ["Modded", "Pokémon", "Fabric"]
			mapURL: "https://map.cobblemon.larnet.eu"
			hidden: true
			order:  40
		}

		"ron": {
			type:    "minecraft"
			title:   "Reign of Nether"
			connect: "ron.mc.northbyte.gg"
			version: "1.20.1"
			loader:  "Fabric"
			mode:    "Creative"
			blurb: {
				en: "A real-time-strategy take on Minecraft — command armies and fight for the Nether. An experimental world we spin up to mess around."
				sv: "Ett realtidsstrategigrepp på Minecraft — för befäl över arméer och kämpa om Nether. En experimentell värld vi drar igång för att busa runt."
			}
			modpack: {
				name:    "Reign of Nether (Optimized)"
				url:     "https://modrinth.com/modpack/reign-of-nether-optimized/version/2.8.0"
				version: "2.8.0"
			}
			featuredMods: [
				{name: "Reign of Nether", kind: "mod", url: "https://modrinth.com/mod/reignofnether", blurb: {en: "RTS gameplay — command units and bases.", sv: "RTS-spel — styr enheter och baser."}},
			]
			tags: ["Modded", "RTS", "Experimental"]
			experimental: true
			hidden:       true
			order:        50
		}
	}
}
