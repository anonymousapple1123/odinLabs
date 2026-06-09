package main
import "core:fmt"

main :: proc() {
	when ODIN_OS == .Linux {
		fmt.println("Welcome Linux User !")
	}
	when ODIN_OS == .Darwin {
		fmt.println("Welcome Rich User !")
	}

	choice: int = display_fibonacci_choice()
	switch choice {
	case 0:
		break
	case 1:
		fmt.print(fibonacci())
	}
}
