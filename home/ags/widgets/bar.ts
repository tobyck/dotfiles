import icons from "lib/icons"

const battery = await Service.import("battery")
const network = await Service.import("network")
const date = Variable("", { poll: [60000, 'date "+%a %b %_d"'] })
const time = Variable("", { poll: [1000, 'date "+%-I:%M %p"'] })

// this will actually do something at some point
const Menu = () => Widget.Label({
	class_name: "menu-icon",
	label: "\udb84\udd05"
})

const Battery = () => Widget.Label({
	label: "test"
}).hook(battery, self => {
	self.label = battery.charging
		? icons.battery.charging
		: icons.battery.normal[Math.floor(battery.percent / icons.battery.normal.length) - 1]
})

const Network = () => Widget.EventBox({
	on_primary_click: () => Utils.execAsync(["kitty", "nmtui"]).catch(err => {
		console.error("Error opening nmtui with kitty: ", err)
	}),
	child: Widget.Icon().hook(network, self => {
		const icon = network[network.primary || "wifi"]?.icon_name
		self.icon = icon || ""
		self.visible = !!icon
	})
})

const Date = () => Widget.Label({
	class_name: "date",
	label: date.bind(),
})

const Time = () => Widget.Label({
	class_name: "time",
	label: time.bind(),
})

const LeftSide = () => Widget.Box({
	class_name: "left-side",
	hpack: "start",
	children: [
		Menu(),
	]
})

const RightSide = () => Widget.Box({
	class_name: "right-side",
	spacing: 16,
	hpack: "end",
	children: [
		Battery(),
		Network(),
		Date(),
		Time()
	]
})

export default (monitor: number = 0) => Widget.Window({
	monitor,
	name: 'bar' + monitor, // unique name for each monitor
	class_name: 'bar',
	anchor: ['top', 'left', 'right'],
	margins: [0, 8],
	exclusivity: 'exclusive', // make the bar push windows out of the way to make space

	child: Widget.CenterBox({
		startWidget: LeftSide(),
		endWidget: RightSide()
	})
})
