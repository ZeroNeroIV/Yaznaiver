package main

import (
	"order-system/initializers"
	"order-system/routes"
)

func init() {
	initializers.LoadEnvVar()
	initializers.ConnectDB()
}
func main() {

	r := routes.SetupRoutes()
	r.Run()
}
