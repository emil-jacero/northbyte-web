// Public, secret-free schema for the NorthByte server catalog.
//
// This is the ONLY contract the website renders from. It deliberately carries
// no operational data (no RCON/restic passwords, S3 keys, ops UUIDs) — those
// live in opm-releases/nas2/minecraft/values.cue and must never reach a public
// build. Hand-author catalog.cue from the public fields of that file.
package northbyte

// A player-facing string rendered in both site languages. The template picks
// the field matching the active language (`index .field site.Language.Lang`).
// UI chrome lives in site/i18n/*.toml instead; this is only for catalog prose.
#I18n: {
	en: string
	sv: string
}

// A curated mod or plugin highlight shown on a server's Details page.
// NOT an exhaustive dump of a modpack's contents — just the notable picks.
#Mod: {
	name:   string
	kind:   "mod" | "plugin"
	blurb?: #I18n
	url?:   string
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

	// One or two sentence, player-facing description (localized en/sv).
	blurb: #I18n

	// Public connect address (shown with a copy button).
	connect: string

	// Version label, e.g. "1.21.1" or "1.21.x".
	version: string

	// Server platform / mod loader.
	loader: "Vanilla" | "Paper" | "Fabric" | "Forge" | "NeoForge"

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

	// Ephemeral / not-persisted servers (e.g. emptyDir worlds). Renders an
	// "Experimental" badge and a "world may reset" note.
	experimental: bool | *false

	// When true, the server is omitted from the homepage list AND no Details
	// page is built for it. Use to take a server offline from the site without
	// deleting its entry. Flip back to false to restore.
	hidden: bool | *false

	// Display order within its type group (ascending).
	order: int | *50
}

// A site-wide operational notice banner (outages, maintenance, incidents).
// Toggle `enabled` to show/hide it, flip back to false once resolved.
#Notice: {
	enabled: bool | *false
	level:   "info" | "warning" | "critical" | *"warning"
	message: #I18n
}

// A single command available to the Fox (regular player) permission tier,
// shown in a backend's Commands tab on the network Details page. `names` is a
// list, not one joined string, because some commands contain their own
// spaces (e.g. "/mv list") and share one description with their aliases.
#Command: {
	names:       [...string]
	description: #I18n
}

// One Minecraft server sitting behind the Velocity proxy. Deliberately a
// slimmed #Server — a backend has no address of its own (players reach it by
// portal, not by connecting directly), but otherwise mirrors #Server's facts.
#NetworkBackend: {
	// Stable identifier (also the map key). Lowercase kebab-case.
	id: string

	// Display name, e.g. "Dungeons".
	title: string

	// One or two sentence, player-facing description (localized en/sv).
	blurb: #I18n

	// Version label, e.g. "26.1.2".
	version: string

	// Server platform / mod loader.
	loader: "Vanilla" | "Paper" | "Fabric" | "Forge" | "NeoForge"

	// Primary game mode.
	mode: "Survival" | "Creative" | "Adventure"

	// Hand-curated mod/plugin highlights for the Details page.
	featuredMods?: [...#Mod]

	// Short descriptive tags rendered as chips.
	tags: [...string]

	// Commands the Fox permission tier can run on this backend.
	foxCommands: [...#Command]

	// Display order among backends (ascending). Map iteration order isn't
	// guaranteed, so the network Details page sorts by this explicitly.
	order: int | *50
}

// The Velocity network: one public address fronting several backends that
// players move between via in-game portals, not by reconnecting.
#Network: {
	// Display name, e.g. "NorthByte Network".
	title: string

	// One or two sentence, player-facing description of the hub+portal model
	// and shared rank ladder (localized en/sv).
	blurb: #I18n

	// Public connect address (shown with a copy button). Single door in —
	// every backend is reached from here via portal, never a separate address.
	connect: string

	// Short descriptive tags rendered as chips.
	tags: [...string]

	// Backends reachable from the hub, keyed by id.
	backends: [ID=string]: #NetworkBackend & {id: ID}
}

#Catalog: {
	// Branding shown in the hero.
	brand: {
		name:    string | *"NorthByte"
		tagline: #I18n
	}
	notice: #Notice | *{enabled: false, level: "warning", message: {en: "", sv: ""}}

	// The Velocity network — a single entry, not part of `servers` below.
	network: #Network

	// Standalone servers outside the network (router-direct, own address).
	servers: [ID=string]: #Server & {id: ID}
}
