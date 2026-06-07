package main

import "core:fmt"
display_fibonacci_choice :: proc() -> int {
	choice: int = input_num("Input choice for fibonacci number :")
	//Add choice value user input instead of hard coded.
	fmt.println("***********************PROGRAM STARTED***********************")

	return choice
}
