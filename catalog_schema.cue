// Public, secret-free schema for the NorthByte server catalog.
//
// This is the ONLY contract the website renders from. It deliberately carries
// no operational data (no RCON/restic passwords, S3 keys, ops UUIDs) — those
// live in opm-releases/nas2/minecraft/values.cue and must never reach a public
// build. Hand-author catalog.cue from the public fields of that file.
package northbyte

// A curated mod or plugin highlight shown on a server's Details page.
// NOT an exhaustive dump of a modpack's contents — just the notable picks.
#Mod: {
	name:  string
	kind:  "mod" | "plugin"
	blurb?: string
	url?:  string
}

// A single public game server. `type` is the extensibility seam — today only
// "minecraft", but the start page groups by type so Valheim/others slot in.
#Server: {
	// Stable identifier (also the map key). Lowercase kebab-case.
	id: string

	// Game / server type — drives the type icon and start-page grouping.
	type: "minecraft" | "valheim" | "other" | *"minecraft"

	// Display name, e.g. "Cobblemon".
	title: string

	// One or two sentence, player-facing description.
	blurb: string

	// Public connect address (shown with a copy button).
	connect: string

	// Version label, e.g. "1.21.1" or "1.21.x".
	version: string

	// Server platform / mod loader.
	loader: "Vanilla" | "Paper" | "Fabric" | "NeoForge"

	// Primary game mode.
	mode: "Survival" | "Creative" | "Adventure"

	// Modpack / content pack, where the server is pack-based.
	modpack?: {
		name:     string
		url?:     string
		version?: string
	}

	// Hand-curated mod/plugin highlights for the Details page.
	featuredMods?: [...#Mod]

	// Short descriptive tags rendered as chips.
	tags: [...string]

	// Public BlueMap web-map URL, where exposed.
	mapURL?: string

	// Ephemeral / not-persisted servers (e.g. emptyDir worlds). Renders an
	// "Experimental" badge and a "world may reset" note.
	experimental: bool | *false

	// Display order within its type group (ascending).
	order: int | *50
}

#Catalog: {
	// Branding shown in the hero.
	brand: {
		name:    string | *"NorthByte"
		tagline: string
	}
	servers: [ID=string]: #Server & {id: ID}
}
