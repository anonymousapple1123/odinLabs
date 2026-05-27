package main
import "core:fmt"

main :: proc() {
	for i := 0; i <= 5; i += 1 do fmt.println("Hello World !")
	fmt.println(">>", fibonacci(5))
}
