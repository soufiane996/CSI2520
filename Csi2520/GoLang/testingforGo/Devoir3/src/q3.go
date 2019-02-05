package main

import (
	"fmt"
	
)

func RandowArray(len int) []float32 {
	
	array:= make([] float32, len)
	for i := range array{
		array [i] = rand.Float32()
	}

	return array
}


func main() {
	rand.Seed(100) //use this seed value 

	out := make (chan float32)
	defer close(out)

	for i:=0; i<1000; i++{
		a := RandowArray(2*(50+rand.Intn(50)))
		go Process(a, out)
	}

	//
	fmt.Println(sum)
}