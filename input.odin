package main
import "core:fmt"
import "core:strings"

import "core:os"
import "core:strconv"

// main :: proc() {
// 	buf: [256]byte
// 	fmt.println("Please enter some text:")
// 	n, err := os.read(os.stdin, buf[:])
// 	if err != nil {
// 		fmt.eprintln("Error reading: ", err)
// 		return
// 	}
// 	str := string(buf[:n])
// 	fmt.println("Outputted text:", str)

// 	str = strings.trim_space(str)
// 	i, ok := strconv.parse_int(str)
// 	if ok {
// 		fmt.println("Inputted integer:", i)
// 	}
// }

input_num :: proc(message: string) -> int {
	fmt.print(message)
	buf: [256]byte
	n, err := os.read(os.stdin, buf[:])
	if err != nil {
		fmt.eprintln("Error reading: ", err)
		return -1
	}
	str := string(buf[:n])
	str = strings.trim_space(str)
	i, ok := strconv.parse_int(str)
	if ok {
		return i
	}
	return -1
}
