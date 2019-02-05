package main

import (
	"fmt"
	"math"
	"math/rand"
)

func Process(inArr []float32, out chan float32) {
	diffedArr := AbsDiff(inArr[len(inArr)/2:], inArr[:len(inArr)/2])
	var sum float32 = 0
	for i := range diffedArr {
		sum += diffedArr[i]
	}
	out <- sum
}
func RandomArray(len int) []float32 {
	tab := make([]float32, len)
	for i := range tab {
		tab[i] = rand.Float32()
	}
	return tab
}

func main() {
	rand.Seed(100)

	out := make(chan float32)
	defer close(out)

	for i := 0; i < 1000; i++ {
		a := RandomArray(2 * (50 + rand.Intn(50)))
		go Process(a, out)
	}

	var sum float32 = 0
	for i := 0; i < 1000; i++ {
		newVal := <-out
		sum += newVal
	}

	fmt.Println(sum)
}
func AbsDiff(l1, l2 []float32) []float32 {
	maxLen := math.Max(float64(len(l1)), float64(len(l2)))
	l3 := make([]float32, int(maxLen))

	for i := range l3 {
		var a, b float32 = 0, 0

		if i < len(l1) {
			a = l1[i]
		}

		if i < len(l2) {
			b = l2[i]
		}

		currDiff := math.Abs(float64(a) - float64(b))
		l3[i] = float32(currDiff)
	}

	return l3
}