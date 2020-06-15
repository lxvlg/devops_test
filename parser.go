package main

import (
	"bufio"
	"fmt"
	"os"
	"regexp"
	"sort"
)

type line = struct {
	//    counter int
	key     string
	value int
}
type List []line

func getpasswds(filename string) List  {
	file, err := os.Open(filename)
	if err != nil {
		panic("couldn't open file")
	}
	defer file.Close()
	passwds := make(map[string]int)
	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanWords)
	for scanner.Scan() {
		pwd := scanner.Text()
		re := regexp.MustCompile("[^0-9a-zA-Z]")
		lenth := len(pwd)
		simple := len(re.ReplaceAllString(pwd, "")) //количество сиволов на 1 балл
		hard := lenth - simple                      //количество символов на 4 балла
		strenth := (simple * 1) + (hard * 4)
		passwds[pwd]=strenth
	}
	passwdsList := make(List, 0)
	for k, v := range passwds {
		passwdsList = append(passwdsList, line{k, v})
	}

	sort.Slice(passwdsList, func(i, j int) bool {
		return passwdsList[i].value > passwdsList[j].value
	})
	return passwdsList
}

func main() {
	var filename = os.Args[1]

	passwds := getpasswds(filename)

	for _, pair := range passwds[:] {
		fmt.Println(pair.value, pair.key)
	}

}
