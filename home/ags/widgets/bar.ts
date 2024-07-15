import icons from "lib/icons"
import { range } from "lib/utils"
import Gtk from "types/@girs/gtk-3.0/gtk-3.0"

const SHORT_DATE_FORMAT = "%a %b %-d"
const LONG_DATE_FORMAT = "%A %B %-e %Y"
const TIME_FORMAT = "%-I:%M %p"

const LEFT_SIDE_BAR_SPACING = 6
const RIGHT_SIDE_BAR_SPACING = 14
const BAR_SUB_GROUP_SPACING = 12

const hyprland = await Service.import("hyprland")
const battery = await Service.import("battery")
const network = await Service.import("network")
const audio = await Service.import("audio")
const date = Variable("", { poll: [60000, `date "+${SHORT_DATE_FORMAT}"`] })
const time = Variable("", { poll: [1000, `date "+${TIME_FORMAT}"`] })

/* 
 * Left widgets
 */

const Logo = () => Widget.Icon({
	class_name: "logo",
	icon: icons.nix
})

const AppName = () => Widget.Label({
	class_name: "app-name",
}).hook(hyprland.active.client, self => {
	let c = hyprland.active.client.class
	if (c) {
		self.label = c
		self.visible = true;
	}
	else self.visible = false
})

/*
 * Centre widgets
 */

const Workspaces = () => Widget.Box({
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

/*
 * Right widgets
 */

const Battery = () => {
	let widget = Widget.Label({
		class_name: "battery",
		tooltip_text: battery.bind("percent").as(p => `Battery: ${p}%`)
	}).hook(battery, self => {
		self.label = battery.charging
			? icons.battery.charging
			: icons.battery.normal[Math.floor(battery.percent / icons.battery.normal.length) - 1]
	})

	widget.set_angle(-90)

	return widget
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
		Logo(),
		AppName()
		// SubGroup([AppName()])
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
	exclusivity: "exclusive", // make the bar push windows out of the way to make space
	child: Widget.CenterBox({
		startWidget: LeftWidgets(),
		centerWidget: Workspaces(),
		endWidget: RightWidgets()
	})
})
