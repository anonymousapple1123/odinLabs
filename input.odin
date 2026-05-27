package main

import "core:bufio"
import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"

read_int :: proc(prompt: string) -> (int, bool) {
	fmt.print(prompt)

	scanner: bufio.Scanner
	stdin_stream := os.stream_from_handle(os.stdin) // on some builds use os.to_stream(os.stdin)
	bufio.scanner_init(&scanner, stdin_stream)

	if !bufio.scanner_scan(&scanner) {
		if err := bufio.scanner_error(&scanner); err != nil {
			fmt.eprintln("scan error:", err)
		}
		return 0, false
	}

	line := strings.trim_space(bufio.scanner_text(&scanner))
	v, err := strconv.parse_i64(line, 10, 0)
	if err != nil {
		return 0, false
	}
	return int(v), true
}

main :: proc() {
	n, ok := read_int("Enter an integer: ")
	if !ok {
		fmt.println("Invalid input")
		return
	}
	fmt.println("You entered", n)
}
