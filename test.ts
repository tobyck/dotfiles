let a = {
	b: {
		c: 5,
		d: true
	}
}

console.log("hello")

function test() {
	const blah = false;
	return [blah, a]
}

let x = test();
let y = a

console.log(x.b.c)
