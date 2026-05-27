package main
import "core:fmt"
fibonacci :: proc() -> int {
	num: int = 0
	fmt.printf("nth fibonacci number : n = ")

	a, b, c: int = 0, 1, 0
	for i := 0; i <= num; i += 1 {
		a = b
		b = c
		c = a + b
	}
	return c
}
