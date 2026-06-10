package main
import "core:fmt"

main :: proc() {
	array()
}

array :: proc() {
	//numbers := [5]int{1, 3, 5, 7, 3}
	//numbers :: [5]int{1, 3, 5, 7, 3} // :: makes Immutable
	//numbers :: [?]int{2, 4, 6}
	values := [?]u8 {
		0 ..= 10 = 0,
		11 ..= 20 = 1,
	}
	//[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
	numlist: [dynamic]int
	defer delete(numlist)
	fmt.println(len(values))
}
