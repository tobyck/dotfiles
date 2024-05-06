export default (monitor: number = 0) => Widget.Window({
	monitor,
	name: 'bar' + monitor, // unique name for each monitor
	class_name: 'bar',
	anchor: ['top', 'left', 'right'],
	margins: [0, 8],
	exclusivity: 'exclusive', // make the bar push windows out of the way to make space

	child: Widget.CenterBox({
		startWidget: Widget.Label('left widget'),
		centerWidget: Widget.Label('center widget'),
		endWidget: Widget.Label('right widget')
	})
})
