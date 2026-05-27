package main
fibonacci :: proc(num: int) -> int {
	a, b, c: int = 0, 1, 0
	for i := 0; i <= num; i += 1 {
		a = b
		b = c
		c = a + b
	}
	return c
}
