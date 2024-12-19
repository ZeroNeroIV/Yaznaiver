package routes

import (
	"search-engine/controllers"

	"github.com/gin-gonic/gin"
)

func SetupRoutes() *gin.Engine {
	r := gin.Default()
	r.GET("/medicines", controllers.GetMedicines)
	r.GET("/medicines/:id", controllers.GetMedicine)

	return r
}
