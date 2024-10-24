package main

import (
	"search-engine/initializers"
	"search-engine/routes"
)

func init() {
	initializers.LoadEnvVar()
	initializers.ConnectDB()
}
func main() {

	r := routes.SetupRoutes()
	r.Run()
}
