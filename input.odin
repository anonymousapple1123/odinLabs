package main

import "core:bufio"
import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

read_int :: proc(prompt: string) -> (int, bool) {
	fmt.print(prompt)

	scanner: bufio.Scanner
	stdin_stream := os.to_stream(os.stdin) // use os.to_stream for this build
	bufio.scanner_init(&scanner, stdin_stream)

	if !bufio.scanner_scan(&scanner) {
		// scanner_error may not return a typed error on some builds; ignore detailed error here
		return 0, false
	}

	line := strings.trim_space(bufio.scanner_text(&scanner))
	v, ok := strconv.atoi(line) // atoi -> (int, bool) on this build
	if !ok {
		return 0, false
	}
	return v, true
}

main :: proc() {
	n, ok := read_int("Enter an integer: ")
	if !ok {
		fmt.println("Invalid input")
		return
	}
	fmt.println("You entered", n)
}
