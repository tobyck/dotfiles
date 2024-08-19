import icons from "lib/icons"
import { range } from "lib/utils"
import Gtk from "types/@girs/gtk-3.0/gtk-3.0"
import { Widget as WidgetType } from "types/@girs/gtk-3.0/gtk-3.0.cjs"

const SHORT_DATE_FORMAT = "%a %b %-d"
const LONG_DATE_FORMAT = "%A %B %-e %Y"
const TIME_FORMAT = "%-I:%M %p"

const LEFT_SIDE_BAR_SPACING = 6
const RIGHT_SIDE_BAR_SPACING = 14
const BAR_SUB_GROUP_SPACING = 12

enum WM { Hyprland, Sway }

const wm: WM = Utils.exec("sway --get-socketpath") === "sway socket not detected."
	? WM.Hyprland
	: WM.Sway

const battery = await Service.import("battery")
const network = await Service.import("network")
const audio = await Service.import("audio")
const applications = await Service.import("applications")
const date = Variable("", { poll: [60000, `date "+${SHORT_DATE_FORMAT}"`] })
const time = Variable("", { poll: [1000, `date "+${TIME_FORMAT}"`] })

/* 
 * Left widgets
 */

const Launcher = () => {
	const defaultText = "Run something..."

	const input = Variable("")
	const autocompletedPart = Variable(defaultText)
	const icon = Variable(icons.nix)
	const appToLaunch = Variable<any>(null) // couldn't figure out what the type signature should be

	const reset = (resetEntry = true, _autocompletedPart = defaultText) => {
		if (resetEntry) {
			input.value = ""
			entry.set_text("")
		}
		autocompletedPart.value = _autocompletedPart
		icon.value = icons.nix
		appToLaunch.value = null
	}

	const entry = Widget.Entry({
		class_name: "launcher-entry",
		max_length: 60,
		on_change: ({ text }) => {
			input.value = text ?? ""

			if (text) {
				const appAndMatch = applications.query("")
					.map(app => ({
						app,
						match: app.name.toLowerCase().match(input.value.toLowerCase())
					}))
					.filter(app => app.match)?.[0]

				if (appAndMatch) {
					const { app, match } = appAndMatch
					appToLaunch.value = app
					autocompletedPart.value = match!.input!.slice(match!.index! + match![0]!.length)
					icon.value = app.icon_name!
				} else reset(false, "")
			} else {
				reset()
			}
		},
		on_accept: () => {
			if (appToLaunch.value) {
				appToLaunch.value.launch()
				reset()
			}
		}
	})

	return Widget.Box({
		children: [
			Widget.Icon({
				class_name: "icon",
				icon: icon.bind()
			}),
			Widget.Overlay({
				child: entry,
				overlays: [
					Widget.Box({
						class_name: "autocomplete-box",
						children: [
							Widget.Label({
								hpack: "start",
								class_name: "launcher-entry-display",
								label: input.bind()
							}),
							Widget.Label({
								class_name: "launcher-autocomplete",
								label: autocompletedPart.bind()
							})
						]
					})
				]
			})
		]
	})
}

/*
 * Centre widgets
 */

let Workspaces: () => WidgetType

if (wm === WM.Hyprland) {
	const hyprland = await Service.import("hyprland")
	Workspaces = () => Widget.Box({
		class_name: "workspaces",
		spacing: 3,
		children: range(9).map(i => 
			Widget.EventBox({
				on_primary_click: _ => Utils.exec("hyprctl dispatch workspace " + i),
				vpack: "center",
				child: Widget.Label().hook(hyprland, self => {
					self.label = hyprland.active.workspace.id === i ? i.toString() : ""
					self.toggleClassName("active", hyprland.active.workspace.id === i)
					self.toggleClassName("occupied", (hyprland.getWorkspace(i)?.windows || 0) > 0)
				})
			})
		)
	})
} else {
	Workspaces = () => Widget.Box({
		class_name: "workspaces",
		spacing: 3
	}).poll(200, self => {
		let activeWorkspace: number, occupiedWorkspaces: number[] = []

		Utils.exec(`fish -c "swaymsg -t get_workspaces | jq -r '.[] | \\"\\(.name) \\(.focused)\\"'"`)
			.split("\n")
			.forEach(l => {
				const [id, focused] = l.split(" ")
				occupiedWorkspaces.push(parseInt(id))
				if (focused === "true") activeWorkspace = parseInt(id)
			})

		self.children = range(10).map(i => {
			const label = Widget.Label(i === activeWorkspace ? i.toString() : "")
			label.toggleClassName("active", i === activeWorkspace)
			label.toggleClassName("occupied", occupiedWorkspaces.includes(i))

			return Widget.EventBox({
				on_primary_click: _ => Utils.execAsync("swaymsg workspace " + i),
				vpack: "center",
				child: label
			})
		})
	})
}

/*
 * Right widgets
 */

const Battery = () => {
	let battery_widget = Widget.Label({
		class_name: "battery-icon",
		tooltip_text: battery.bind("percent").as(p => `Battery: ${p}%`)
	}).hook(battery, self => {
		self.label = battery.percent == 100
			? icons.battery.full
			: icons.battery.range[~~(battery.percent / icons.battery.range.length)]
	})

	battery_widget.set_angle(-90)

	let is_charging_widget = Widget.Label({
		class_name: "is-charging",
		visible: battery.bind("charging"),
		label: icons.battery.lightning_bolt
	})

	return Widget.Box({
		spacing: 2,
		children: [
			battery_widget,
			is_charging_widget
		]
	})
}

const Network = () => Widget.EventBox({
	on_primary_click: () => Utils.execAsync(["kitty", "nmtui"]).catch(err => {
		console.error("Error opening nmtui with kitty: ", err)
	}),
	tooltip_text: network.bind('connectivity').as(c => "Connectivity: " + c),
	child: Widget.Icon().hook(network, self => {
		const icon = network[network.primary || "wifi"]?.icon_name
		self.icon = icon || ""
		self.visible = !!icon
	})
})

const VolumeIndicator = () => Widget.EventBox({
    on_primary_click: () => audio.speaker.is_muted = !audio.speaker.is_muted,
    child: Widget.Icon().hook(audio.speaker, self => {
		const volume = audio.speaker.volume * 100;

		let icon = audio.speaker.is_muted
			? "muted"
			: ([
				[101, "overamplified"],
				[67, "high"],
				[34, "medium"],
				[1, "low"],
				[0, "muted"]
			] as [number, string][]).find(([threshold]) => threshold <= volume)?.[1];

        self.icon = `audio-volume-${icon}-symbolic`;
        self.tooltip_text = `Volume: ${Math.floor(volume)}%`;

		if (audio.speaker.is_muted) {
			self.tooltip_text += " (muted)"
		}
    }),
})

const Date = () => Widget.Label({
	class_name: "date",
	label: date.bind(),
	tooltip_text: Utils.exec(`date +"${LONG_DATE_FORMAT}"`)
})

const Time = () => Widget.Label({
	class_name: "time",
	label: time.bind(),
})

/*
 * Putting everything together into one widget
 */

const LeftWidgets = () => Widget.Box({
	class_name: "left-side",
	spacing: LEFT_SIDE_BAR_SPACING,
	hpack: "start",
	children: [
		Launcher()
	]
})

const SubGroup = (children: Gtk.Widget[], extra_class_name = "") => Widget.Box({
	class_name: "subgroup" + extra_class_name,
	spacing: BAR_SUB_GROUP_SPACING,
	children
})

const RightWidgets = () => Widget.Box({
	class_name: "right-side",
	spacing: RIGHT_SIDE_BAR_SPACING,
	hpack: "end",
	children: [
		SubGroup([Battery(), Network(), VolumeIndicator()], " .right-side-icons"),
		SubGroup([Date(), Time()])
	]
})

export default (monitor: number = 0) => Widget.Window({
	monitor,
	name: "bar" + monitor, // unique name for each monitor
	class_name: "bar",
	anchor: ["top", "left", "right"],
	margins: [0, 8],
    keymode: "on-demand",
	exclusivity: "exclusive", // make the bar push windows out of the way to make space
	child: Widget.CenterBox({
		startWidget: LeftWidgets(),
		centerWidget: Workspaces(),
		endWidget: RightWidgets()
	})
})
